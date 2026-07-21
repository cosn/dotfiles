---
name: pr
description: Use when the user asks to address GitHub PR review comments on a pull request. Fetch unresolved comments, triage each one, make requested code changes where appropriate, reply only when discussion is needed, and update the existing PR branch.
---

# PR - Address GitHub PR Comments

Use the PR number, URL, or branch named in the user's request. If the user does not provide one, detect the PR for the current branch.

## Process

1. **Get PR info.** If no PR number/URL given, detect from current branch.
   Run: gh pr view <pr_number> --json number,headRefName,url,headRepository
   Extract the owner, repo, branch, and pr number from the result.

2. **Fetch review comments.**
   Run: gh api repos/<owner>/<repo>/pulls/<pr_number>/comments

3. **Checkout the branch.**
   Run: gh stack checkout <pr_number>
   If the PR is not part of a stack, fall back to: git fetch origin && git checkout -B <branch> origin/<branch>

4. **Triage each unresolved comment.** Skip comments where the PR author already replied. For each remaining comment, show:
   - diff_hunk (the code context)
   - comment body, user.login, path, line (or original_line)
   - Your recommendation: **address** (fix the code), **respond** (discuss/clarify), or **ignore** (nitpick, outdated, or already handled)

   Ask the user to confirm or override the recommendations before acting when there is more than one plausible path. If the user already gave explicit instructions, proceed.

5. **Execute the chosen action for each comment.**
   - **address**: edit the file. No reply - the fix speaks for itself. Commit/push via gh-stack (see below).
   - **respond**: post a reply (only when not fixing - discussing, clarifying, or pushing back):
     Run: gh api repos/<owner>/<repo>/pulls/<pr_number>/comments -X POST -f body="message" -F in_reply_to=<comment_id>
   - **ignore**: skip silently, no reply.

   Batch all code fixes into a single commit when possible. Push once at the end.

### Committing to the existing PR (gh-stack)

gh-stack has no amend command; use plain git to amend, then restack and push:

```bash
git add <file1> <file2> ...            # only the files you edited
git commit --amend --no-edit           # amend the current branch with staged changes
gh stack rebase --upstack --no-trunk   # restack branches above; skip if the PR is the top of the stack
gh stack push                          # force-with-lease push of all stack branches; open PRs pick up the new commits
```

Do NOT use `git add -A` here - it stages all tracked changes. `gh stack push` never creates new PRs, so it is safe for update-only pushes. If the branch is not part of a stack, use `git push --force-with-lease origin <branch>` instead.

If `gh`, `git fetch`, or `gh stack push` needs network access and fails due sandboxing or authentication, request escalation instead of working around it.

6. **Show summary.** List each comment and what was done (addressed, responded, ignored).

## Reply style

- lowercase, concise, no fluff
- examples: "done.", "good catch. fixed.", "intentional; needed for X edge case."
