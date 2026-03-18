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
   !`gh pr view {pr} --json number,headRefName,url,headRepository`
   Extract `{owner}`, `{repo}`, `{branch}`, and `{pr}` from the result.

2. **Fetch review comments.**

   !`gh api repos/{owner}/{repo}/pulls/{pr}/comments`

3. **Checkout the branch.**

   !`git fetch origin && git checkout -B {branch} origin/{branch}`

4. **Triage each unresolved comment.** Skip comments where the PR author already replied. For each remaining comment, show:
   - `diff_hunk` (the code context)
   - comment `body`, `user.login`, `path`, `line` (or `original_line`)
   - Your recommendation: **address** (fix the code), **respond** (discuss/clarify), or **ignore** (nitpick, outdated, or already handled)

   Use the AskUserQuestion tool to confirm or override each recommendation before acting.

5. **Execute the chosen action for each comment.**
   - **address**: edit the file, commit, push, then reply:
     !`gh api repos/{owner}/{repo}/pulls/{pr}/comments -X POST -f body="message" -F in_reply_to={comment_id}`
   - **respond**: post a reply using the same API above with the agreed message.
   - **ignore**: skip silently, no reply.

   Batch all code fixes into a single commit when possible. Push once at the end.

6. **Show summary.** List each comment and what was done (addressed, responded, ignored).

## Reply style

- lowercase, concise, no fluff
- examples: "done.", "good catch. fixed.", "intentional; needed for X edge case."
