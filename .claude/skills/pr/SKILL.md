---
name: pr
description: Address GitHub PR comments - fetch, triage, and resolve unresolved review comments on a pull request
user_invocable: true
arguments:
  - name: args
    description: PR number or URL (optional; defaults to current branch's PR)
    required: false
---

# PR - Address GitHub PR Comments

$ARGUMENTS

## Process

1. **Get PR info.** If no PR number/URL given, detect from current branch.
   Run: gh pr view <pr_number> --json number,headRefName,url,headRepository
   Extract the owner, repo, branch, and pr number from the result.

2. **Fetch review comments.**
   Run: gh api repos/<owner>/<repo>/pulls/<pr_number>/comments

3. **Checkout the branch.**
   Run: git fetch origin && git checkout -B <branch> origin/<branch>

4. **Triage each unresolved comment.** Skip comments where the PR author already replied. For each remaining comment, show:
   - diff_hunk (the code context)
   - comment body, user.login, path, line (or original_line)
   - Your recommendation: **address** (fix the code), **respond** (discuss/clarify), or **ignore** (nitpick, outdated, or already handled)

   Use the AskUserQuestion tool to confirm or override each recommendation before acting.

5. **Execute the chosen action for each comment.**
   - **address**: edit the file. No reply - the fix speaks for itself. Commit/push via graphite (see below).
   - **respond**: post a reply (only when not fixing - discussing, clarifying, or pushing back):
     Run: gh api repos/<owner>/<repo>/pulls/<pr_number>/comments -X POST -f body="message" -F in_reply_to=<comment_id>
   - **ignore**: skip silently, no reply.

   Batch all code fixes into a single commit when possible. Push once at the end.

### Committing to the existing PR (graphite)

Mirror the user's `gtmas` alias (`gt ma && gt s --stack --update-only`), but stage only the files you edited so unrelated tracked changes are not swept in:

```bash
gt add <file1> <file2> ...   # only the files you edited
gt m                          # modify (amend) the current branch with staged changes
gt s --stack --update-only    # submit/update the stack
```

Do NOT use `gt ma` here - it stages all tracked changes.

6. **Show summary.** List each comment and what was done (addressed, responded, ignored).

## Reply style

- lowercase, concise, no fluff
- examples: "done.", "good catch. fixed.", "intentional; needed for X edge case."
