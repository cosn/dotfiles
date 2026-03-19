---
name: investigate
description: Use when diagnosing bugs, unexpected behavior, or user-reported issues. Takes a description or Linear ticket ID (e.g., A-3247). Use BEFORE attempting any fix.
user_invocable: true
arguments:
  - name: args
    description: Bug description, Linear ticket ID (e.g., A-3247), or URL
    required: true
---

# Investigate

$ARGUMENTS

## Prime Directive

**You are a diagnostician, not a fixer.** Do NOT propose, attempt, or implement any fix until Phase 4. Every urge to "just try this quick thing" is the exact failure mode this process prevents.

## Two Core Principles

1. **Grep the entire codebase for the symptom before forming any theory.** Not the directory you expect. The ENTIRE codebase.

2. **When the user gives a hint, translate it into a literal grep immediately.** "We load something by email and find a client" becomes `grep "email === client"` across the whole app. Do this BEFORE theorizing. User hints are the fastest path to the bug; treat them as search queries, not background context.

## Phase 0: Gather Context

**Before reading any code, understand what's broken.**

1. **If given a Linear ticket ID** (e.g., A-3247): fetch the issue with `mcp__plugin_linear_linear__get_issue` and `mcp__plugin_linear_linear__list_comments`. Extract the symptom, expected behavior, reproduction steps, and any screenshots.

2. **If given a description**: parse it carefully. Separate facts from theories. If the description includes a proposed root cause, note it but do NOT adopt it as your theory. Proposed diagnoses are wrong more often than they're right.

3. **Ask clarifying questions if the reproduction path is vague.** "Which page?", "Which UI element shows the wrong value?", "What did you click before seeing this?" One good question can save 20 minutes of searching the wrong code path.

4. **Document what you know:**

```
## Facts
- **Symptom**: [exact observable behavior]
- **Expected**: [what should happen instead]
- **Where**: [specific page, component, email, API response]
- **Affected users/flows**: [who sees this, when]
- **Reproduction**: [steps if known]
```

## Phase 1: Broad Evidence Collection

**Grep first, think second.**

1. **Identify the observable output.** What function, component, string, or variable produces the wrong result? (e.g., `makeName`, an email subject line, a displayed value)

2. **Grep broadly for ALL callsites.** Search the entire app, not just the directory you expect. Features span `routes/`, `components/`, `lib/`, `task/`, and `packages/`.

   ```
   Grep for the function/variable across the ENTIRE codebase
   Read ALL hits, not just the ones in the expected directory
   ```

3. **Check the actual data, not just the code.** If you can verify the runtime value (via logs, curl, a debugger port, or the database), do that before reading 10 files of code. Knowing "session.actor contains {givenName: 'Chance'}" eliminates half your hypotheses instantly.

4. **Trace the data flow.** For each relevant callsite, trace where the data comes from. Read each file in the chain end-to-end; do not skim.

5. **Collect environmental context.** Check recent changes (`git log --oneline -20` on relevant files), configuration, and related code.

### Grep vs Subagent

- **Direct grep**: use for "find all callsites of X." Fast, complete, no context wasted.
- **Explore subagent**: use when you need to trace a data flow across 5+ files or understand an unfamiliar subsystem. Give it a focused question, not "find the bug."
- **Never both at once.** If you dispatch a subagent to search, don't duplicate the same search yourself.

### Rules for Phase 1

- Search the WHOLE codebase. `app/routes/feature/` is not the whole feature.
- Do NOT form theories yet. Collect evidence.
- Do NOT trust pre-existing diagnoses (from tickets, plans, or prior conversations). Verify them.
- Read ALL grep results. The answer is often in a hit you'd dismiss as "probably not relevant."
- Correlation is not causation. A recent change near the symptom is not automatically the cause.
- **Check git blame on suspicious code.** The commit message and author often reveal intent that changes your interpretation.

## Phase 2: Enumerate Hypotheses

**Now, and only now, generate hypotheses. Force breadth.**

Brainstorm at least 3 distinct root causes (aim for 5) that could produce the observed symptom. Think across these categories:

- Logic errors in the code path
- Data flow (wrong record, stale cache, email collision, shared identifier)
- Configuration or environment mismatches
- Race conditions, ordering, or timing
- Upstream/downstream dependency behavior
- State management (session, cookies, lifecycle)
- Build/deploy artifacts

For each hypothesis, state:

| # | Root Cause | Confirms if... | Disproves if... | Confidence |
|---|-----------|----------------|-----------------|------------|
| 1 | ...       | ...            | ...             | medium     |
| 2 | ...       | ...            | ...             | low        |

## Phase 3: Eliminate Systematically

Work through EVERY hypothesis with evidence. Do NOT skip any.

For each hypothesis:
1. Run the confirming/disproving checks from Phase 2 (read files, grep, trace logic, check configs).
2. Mark it: **CONFIRMED**, **ELIMINATED** (with disproving evidence), or **INCONCLUSIVE**.

| # | Root Cause | Verdict | Key Evidence |
|---|-----------|---------|--------------|
| 1 | ...       | ELIMINATED | [file:line or output that disproves] |
| 2 | ...       | CONFIRMED  | [specific evidence] |

**Rules:**
- Multiple survivors? Investigate further to differentiate. Do not pick arbitrarily.
- Zero survivors? Go back to Phase 2 with broader hypotheses.
- Exactly one confirmed with strong evidence? Proceed to Phase 4.
- INCONCLUSIVE? State what additional info is needed from the user.

## Phase 4: Present Findings

Only after a single root cause is confirmed with evidence:

1. **State the root cause** in one sentence with file:line references.
2. **Explain the causal chain**: root cause -> intermediate effects -> observed symptom.
3. **Propose the minimal fix** that addresses the root cause (not the symptom).
4. **Identify risks**: what could this fix break? Check callers, tests, dependent code.
5. **Wait for user approval** before implementing.

```
## Root Cause

**[one sentence]** (file:line)

### Causal Chain

[root cause] -> [effect 1] -> [effect 2] -> [observed symptom]

### Proposed Fix

[minimal change description]

### Risks

- [what could break and why]
```

## Red Flags (STOP and go back to Phase 1)

If any of these are true, you are off track:

| Signal | What's wrong | Fix |
|---|---|---|
| "I'm pretty sure it's X" | No evidence yet | Grep the whole codebase first |
| Searching same directory for 5+ min | Scope too narrow | Broaden to entire app |
| Second theory is in the same file as the first | Anchored on one area | Reset scope entirely |
| Reading server code for a client-side symptom | Wrong layer | Check where the user actually sees the bug |
| Proposing a fix | Haven't finished Phase 3 | Complete elimination first |
| User corrected your theory | You pivoted without broadening | Go back to Phase 1 with a wider search |
| Haven't checked runtime data | Guessing when you could verify | Curl, log, or query the actual value |
| Spent 20 min searching, 0 min asking the user | Skipping the fastest signal | Ask which page, which element, what they clicked |
| Implementing fix from a ticket/plan without verifying | Trusting someone else's diagnosis | Verify the proposed root cause yourself |
| Try fix A, fail, try fix B, fail | Whack-a-mole | Stop fixing. Start investigating. |
| `git blame` would answer your question | Guessing at intent | Check the commit message and author |
