---
name: prr
description: Deep code review with parallel analysis passes, structured scoring, and GitHub review posting
user_invocable: true
arguments:
  - name: args
    description: PR number, PR URL, or branch name (optional; defaults to current branch)
    required: false
---

# Review

$ARGUMENTS

## Resolving the Target

1. If `$ARGUMENTS` is a PR number or URL, fetch the diff and metadata. Run these commands:
   - gh pr diff <pr_number>
   - gh pr view <pr_number> --json number,title,body,headRefName,baseRefName,headRefOid,headRepository,files

   Extract the owner, repo, pr number, branch, base, and commitSha from the result.

2. If `$ARGUMENTS` is a branch name, diff against the base branch. Run:
   - git diff main...<branch_name>

3. If `$ARGUMENTS` is empty, diff the current branch against main. Run:
   - git diff main...HEAD

Get the list of changed files from the diff output. You will need it for all passes below.

## Reading Files from the Correct Source

How agents read changed files depends on which mode resolved above:

- **PR number/URL**: Head = git show <headRefName>:<path>, Base = git show <baseRefName>:<path>
- **Branch name**: Head = git show <branch_name>:<path>, Base = git show main:<path>
- **Current branch** (no args): Head = read directly from disk, Base = git show main:<path>

Pass the mode, refs, diff, and changed file list to every agent so they know how to read files. For grepping the broader codebase (e.g., finding existing patterns), always use the base ref as the reference point.

## Parallel Analysis Passes

Run every pass below in parallel using the Agent tool. Each pass operates on the changed files identified above.

### Pass 1: Correctness Risks

Read every changed file end-to-end (not just the diff hunks; you need surrounding context). Identify:

- **Database migrations**: schema changes without backwards compatibility, missing rollback, data loss risk, lock contention on large tables.
- **Type safety**: unchecked casts, `any` usage, missing null checks, type assertions that hide errors.
- **Edge cases**: off-by-one, empty collections, concurrent access, error paths that swallow failures.
- **Security**: injection vectors, auth bypasses, secrets in code, unsafe deserialization.
- **Data integrity**: race conditions, missing transactions, partial writes without cleanup.

For each finding, think step-by-step about whether it is a real problem or a false alarm. Only surface findings you would bet money on.

### Pass 2: Design Consistency

Grep the codebase for existing patterns related to the changed code. Look for:

- **Naming conventions**: do new functions/variables/types follow the existing style?
- **Error handling patterns**: does the new code handle errors the same way the rest of the codebase does?
- **Architectural patterns**: is the new code in the right layer? Does it respect existing boundaries?
- **Duplicated logic**: does similar functionality already exist elsewhere that should be reused?
- **Import/dependency patterns**: are new imports consistent with what the rest of the codebase uses?

Flag inconsistencies with established conventions. Back each finding with a specific example from the existing codebase.

### Pass 3: Test Coverage Gaps

Check test coverage for the changed code paths:

- Are there tests for the new/changed code? Find the relevant test files.
- For each new code path (branches, error cases, edge cases), is there a corresponding test?
- Are existing tests still valid after the changes, or do they need updating?
- Are there integration-level scenarios that should be tested but aren't?

Do not suggest mock-heavy tests. Prefer unit tests with real objects or end-to-end tests.

### Pass 4: Style & Rules Compliance

Check if the repository has a `.claude/rules/` directory. If it does:

1. Read every rules file in `.claude/rules/`.
2. Each rules file uses YAML frontmatter with a `paths` glob to scope which file types it applies to.
3. For each changed file, match it against the frontmatter `paths` globs to determine which rules apply.
4. Check changed files against every applicable rule.

For each violation, cite the specific rule and the line that breaks it. Only flag clear violations.

If no `.claude/rules/` directory exists, skip this pass and note "No project rules found."

### Pass 5: Performance & Runtime Complexity

Analyze the changed code for performance concerns:

- **Algorithmic complexity**: loops, nested iterations, or recursive calls that scale poorly (O(n^2) or worse).
- **Expensive operations in hot paths**: large allocations, synchronous I/O, or heavy computation inside loops.
- **Database query patterns**: N+1 queries, missing indices implied by new WHERE/JOIN clauses, unbounded SELECTs.
- **React-specific** (only if `.tsx`/`.jsx` files changed): unnecessary re-renders from missing `memo`/`useMemo`/`useCallback`, inline object/array literals in JSX, `useEffect` misuse for derived state, overfetching in data hooks.

For each finding, explain the impact and suggest a concrete fix.

### PR Comments Triage (PR mode only)

**Only run this when reviewing a PR.** Skip for branch or current-branch reviews.

Fetch unresolved review comments by running:
- gh api repos/<owner>/<repo>/pulls/<pr_number>/comments

For each unresolved comment:

1. Read the referenced file and line to understand the current state.
2. Determine if the comment has already been addressed by changes in the current diff.
3. Classify:
   - **agree**: valid point, not yet addressed. Include as a finding with appropriate severity.
   - **already addressed**: current code handles what the comment asks for. Note so author can resolve.
   - **pushback**: comment is incorrect or would make the code worse. Provide rationale.

## Scoring

- **critical**: data loss, security vulnerability, production crash, or silent corruption. Must fix before merge.
- **major**: likely bugs, important convention violations, or significant tech debt. Should fix before merge.
- **minor**: style inconsistency, small improvement, or nitpick. Nice to fix but not blocking.

Only report findings you are confident about. False positives waste everyone's time.

## Output Format

Present the review as a single structured report:

```
## Risk Assessment (Pass 1)

- **[severity]** file:line - description
  > relevant code snippet or diff hunk
  rationale

## Design Consistency (Pass 2)

- **[severity]** file:line - description
  > existing pattern (file:line) vs. new code
  suggestion

## Test Gaps (Pass 3)

- **[severity]** description of missing coverage
  code path: file:line
  suggested test scenario (one sentence)

## Style & Rules Compliance (Pass 4)

- **[severity]** file:line - description
  > rule violated: rule file name + quoted rule text
  suggestion

(Or "No project rules found.")

## Performance (Pass 5)

- **[severity]** file:line - description
  > complexity/impact analysis
  suggested fix

## PR Comment Triage (if PR mode)

- **agree** file:line - @user's comment summary
  > added as [severity] finding above

- **already addressed** file:line - @user's comment summary
  > what the current code does that satisfies the comment

- **pushback** file:line - @user's comment summary
  > rationale for disagreeing

(Omit for non-PR reviews.)

## Summary

| Severity | Count |
|----------|-------|
| Critical | N     |
| Major    | N     |
| Minor    | N     |

## Verdict

**APPROVE** / **COMMENT**

[One-paragraph justification. If commenting, list the critical and major items the author should address.]
```

Default to APPROVE. Trust author to address feedback. Use COMMENT only when finding genuinely big problems (multiple critical issues, fundamental design flaw, security holes, data loss risk) that warrant blocking until discussed. Single major nit, style issues, test gaps: still APPROVE.

We never use REQUEST CHANGES on this team.

After presenting report, **await user instruction** on which comments to post and whether to approve or comment.

## Creating Pending Review Comments

To post line-specific comments to a pending review (not submitted yet), use the GitHub API directly.

### Step 1: Get the head commit SHA

Run: gh pr view <pr_number> --json headRefOid -q .headRefOid

### Step 2: Create pending review with comments

Use `gh api` with `--input -` and a heredoc. **Critical fields:**

- `commit_id` (required): the head commit SHA from step 1
- `body`: can be empty string for pending reviews
- `comments`: array of comment objects
- **Do NOT include `event` field**; omitting it creates a PENDING review

Example command:

    gh api repos/<owner>/<repo>/pulls/<pr_number>/reviews \
      --method POST \
      --input - << 'EOF'
    {
      "commit_id": "abc123...",
      "body": "",
      "comments": [
        {
          "path": "path/to/file.ts",
          "line": 81,
          "body": "Your comment here with markdown support."
        }
      ]
    }
    EOF

### Step 3: Submit the review (when ready)

Run: gh api repos/<owner>/<repo>/pulls/<pr_number>/reviews/<review_id>/events --method POST -f event=COMMENT

Event options: `APPROVE` or `COMMENT`. Never `REQUEST_CHANGES`, team doesn't use it.

### Adding More Comments to Existing Pending Review

**Only one pending review per PR.** To add more comments:

1. Delete the existing pending review:
   Run: gh api repos/<owner>/<repo>/pulls/<pr_number>/reviews/<review_id> --method DELETE
2. Create a new pending review with ALL comments (old + new) in one request.

### Common Mistakes

- Using `-f comments='[...]'`; gh CLI doesn't parse JSON arrays correctly, use `--input -` instead
- Including `"event": "PENDING"`; this is invalid, omit the event field entirely
- Forgetting `commit_id`; required for line comments to work
- Trying to create multiple pending reviews; only one allowed per user per PR

## Approving PRs

When approving as-is, run: gh pr review <pr_number> --approve

No body text. Don't summarize what the patch does; the author already knows.

## Comment Style

- lowercase, concise, no fluff
- "this could cause issues with X." / "consider using Y instead." / "nit: prefer Z here."
