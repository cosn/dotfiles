---
name: interview
description: Use before planning a non-trivial task when requirements are ambiguous. Explores the codebase and any linked ticket/doc first, then interviews the user until every branch of the decision tree is resolved, and produces a scoped spec ready for writing-plans.
user_invocable: true
arguments:
  - name: args
    description: The topic or task to interview about
    required: true
---

$ARGUMENTS

Interview me relentlessly about this task until we reach a shared understanding. Walk down each branch of the decision tree, resolving dependencies between decisions one by one. For each question, provide your recommended answer.

Ask questions one at a time via AskUserQuestion. Keep going until everything is exhausted - do not stop early.

If a question can be answered by exploring the codebase, or by reading a linked ticket/RFD/doc, do that instead of asking.

Probe the non-obvious: non-goals and scope boundaries, success criteria, failure modes, hidden constraints (perf, compliance, deadlines, stakeholders), blast radius, and tradeoffs the user has already made vs. still open. Skip questions that merely confirm things already stated.

When the tree is fully resolved, produce a short spec: **Goal** (one sentence), **Non-goals**, **Constraints**, **Success criteria**, **Open questions** (only if genuinely unresolvable - do not invent answers). Offer to hand off to `superpowers:writing-plans`.
