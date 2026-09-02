---
name: investigate
description: Use when diagnosing bugs, unexpected behavior, or user-reported issues. Takes a description, Linear ticket ID (e.g., A-3247), Sentry issue ID (e.g., API-SRV-123), or URL. Use BEFORE attempting any fix.
user_invocable: true
arguments:
  - name: args
    description: Bug description, Linear ticket ID (e.g., A-1234), Sentry issue ID (e.g. API-SRV-123) or URL
    required: true
---

# Investigate

$ARGUMENTS

## Prime Directive

**You are a diagnostician, not a fixer.** The deliverable is a root cause confirmed by evidence plus a proposed fix (Phase 4); nothing gets implemented before that, and then only with the user's approval.

## Two Core Principles

1. **Grep the entire codebase for the symptom before forming any theory.** Features span `routes/`, `components/`, `lib/`, `task/`, and `packages/`, so the directory you expect is rarely the whole feature; read every hit, including the ones that look irrelevant.

2. **When the user gives a hint, translate it into a literal grep immediately.** "We load something by email and find a client" becomes `grep "email === client"` across the whole app. Do this BEFORE theorizing. User hints are the fastest path to the bug; treat them as search queries, not background context.

## Phase 0: Gather Context

**Before reading any code, understand what's broken.**

1. **If given a Linear ticket ID** (e.g., A-3247) **or a Linear URL**: fetch the issue with `mcp__plugin_linear_linear__get_issue` and `mcp__plugin_linear_linear__list_comments`. Extract the symptom, expected behavior, reproduction steps, and any screenshots.

2. **If given a Sentry issue ID** (e.g., API-SRV-123) **or a Sentry URL**: fetch it with `mcp__plugin_sentry_sentry__get_sentry_resource` (use `mcp__plugin_sentry_sentry__search_issues` first if you only have a partial reference). Extract the stack trace, breadcrumbs, event tags, affected users/environment, and first/last seen + frequency. Treat the stack trace as a lead, not a diagnosis; still verify by reading the actual code path.

3. **If given a description**: parse it carefully. Separate facts from theories. If the description includes a proposed root cause, note it but do NOT adopt it as your theory. Proposed diagnoses are wrong more often than they're right.

4. **Ask clarifying questions if the reproduction path is vague.** "Which page?", "Which UI element shows the wrong value?", "What did you click before seeing this?" One good question can save 20 minutes of searching the wrong code path.

5. **Document what you know:**

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

2. **Grep for every callsite** of that function or variable across the codebase.

3. **Check the actual data, not just the code.** If you can verify the runtime value (via logs, curl, a debugger port, or the database), do that before reading 10 files of code. Knowing "session.actor contains {givenName: 'Chance'}" eliminates half your hypotheses instantly.

4. **Trace the data flow.** For each relevant callsite, trace where the data comes from. Read each file in the chain end-to-end; do not skim.

5. **Collect environmental context.** Check recent changes (`git log --oneline -20` on relevant files), configuration, and related code. Run `git blame` on suspicious lines; the commit message often reveals intent that changes your reading. A recent change near the symptom is a lead, not a verdict.

### Grep vs Subagent

- **Direct grep**: use for "find all callsites of X." Fast, complete, no context wasted.
- **Explore subagent**: use when you need to trace a data flow across 5+ files or understand an unfamiliar subsystem. Give it a focused question, not "find the bug."
- **Never both at once.** If you dispatch a subagent to search, don't duplicate the same search yourself.

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

| #   | Root Cause | Confirms if... | Disproves if... | Confidence |
| --- | ---------- | -------------- | --------------- | ---------- |
| 1   | ...        | ...            | ...             | medium     |
| 2   | ...        | ...            | ...             | low        |

## Phase 3: Eliminate Systematically

Test every hypothesis against evidence.

For each hypothesis:

1. Run the confirming/disproving checks from Phase 2 (read files, grep, trace logic, check configs).
2. Mark it: **CONFIRMED**, **ELIMINATED** (with disproving evidence), or **INCONCLUSIVE**.

| #   | Root Cause | Verdict    | Key Evidence                         |
| --- | ---------- | ---------- | ------------------------------------ |
| 1   | ...        | ELIMINATED | [file:line or output that disproves] |
| 2   | ...        | CONFIRMED  | [specific evidence]                  |

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

## Red Flags

Signs you are off track, each of which means going back to Phase 1 with a wider search: your second theory lives in the same file or directory as the first (anchored); you are reading server code for a symptom the user sees in the client (wrong layer); the user corrected your theory and you pivoted to a neighbor instead of broadening; you have tried a fix, watched it fail, and are reaching for the next one (stop fixing, start investigating).
