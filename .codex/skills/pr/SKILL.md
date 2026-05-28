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
   Run: git fetch origin && git checkout -B <branch> origin/<branch>

4. **Triage each unresolved comment.** Skip comments where the PR author already replied. For each remaining comment, show:
   - diff_hunk (the code context)
   - comment body, user.login, path, line (or original_line)
   - Your recommendation: **address** (fix the code), **respond** (discuss/clarify), or **ignore** (nitpick, outdated, or already handled)

   Ask the user to confirm or override the recommendations before acting when there is more than one plausible path. If the user already gave explicit instructions, proceed.

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

If `gh`, `git fetch`, or `gt s` needs network access and fails due sandboxing or authentication, request escalation instead of working around it.

6. **Show summary.** List each comment and what was done (addressed, responded, ignored).

## Reply style

- lowercase, concise, no fluff
- examples: "done.", "good catch. fixed.", "intentional; needed for X edge case."
