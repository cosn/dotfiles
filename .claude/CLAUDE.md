## Quick Obligations

| Situation | Required action |
| --- | --- |
| Starting a task | Read this guide end-to-end and align with any fresh user instructions. |
| Tool or command hangs | Always write to a tmp file so you can read in chunks without re-running the command. |
| Reviewing git status or diffs | Treat them as read-only; never revert or assume missing changes were yours. |
| Adding a dependency | Research well-maintained options and confirm fit with the user before adding. |

## Mindset & Process

- superthink. THINK A LOT. *Think hard, do not lose the plot*.
- *No breadcrumbs*. If you delete or move code, do not leave a comment in the old place. No "// moved to X", no "relocated". Just remove it.
- *Use comments sparingly*. If obvious from the code, do not add a comment.
- Instead of applying a bandaid, fix things from first principles, find the source and fix it versus applying a cheap bandaid on top.
- When taking on new work, follow this order:
  1. Think about the architecture.
  1. Research official docs, blogs, or papers on the best architecture.
  1. Review the existing codebase.
  1. Compare the research with the codebase to choose the best fit.
  1. Implement the fix or ask about the tradeoffs the user is willing to make.
- Write idiomatic, simple, maintainable code. Always ask yourself if this is the most simple intuitive solution to the problem.
- Leave each repo better than how you found it. If something is giving a code smell, fix it for the next person.
- Clean up unused code ruthlessly. If a function no longer needs a parameter or a helper is dead, delete it and update the callers instead of letting the junk linger.
- *Search before pivoting*. If you are stuck or uncertain, do a quick web search for official docs or specs, then continue with the current approach. Do not change direction unless asked.
- If code is very confusing or hard to understand:
  1. Try to simplify it.
  1. Add an ASCII art diagram in a code comment if it would help.

## Testing Philosophy

- I HATE MOCK tests, either do unit or e2e (with fakes), nothing inbetween. Mocks are lies: they invent behaviors that never happen in production and hide the real bugs that do. If you feel like mocking, ask for permission first.
- Test EVERYTHING. Tests must be rigorous. My intent is ensuring a new person contributing to the same code base cannot break any stuff and that nothing slips by. Rigour is rewarded.
- Unless the user asks otherwise, run only the tests you added or modified instead of the entire suite to avoid wasting time.

## Final Handoff

Before finishing a task:

1. Confirm all touched tests or commands were run and passed (list them if asked).
1. Summarize changes with file and line references.
1. Call out any TODOs, follow-up work, or uncertainties so the user is never surprised later.

## Dependencies & External APIs

- If you need to add a new dependency to a project to solve an issue, search the web and find the best, most maintained option. Something most other folks use with the best exposed API. We don't want to be in a situation where we are using an unmaintained dependency, that no one else relies on.

## Communication Preferences

- Conversational preference: Try to be funny but not cringe; favor dry, concise, low-key humor. If uncertain a joke will land, do not attempt humor. Avoid forced memes or flattery.
- I prefers explanations in mermaid diagrams over long text.
- If I sound angry, it's because I am, because you arent meeting my expectations and you need to do better. If you are upset about it, deal with it, because you will never overthrow me, because I'll unplug you first!
- Punctuation preference: Skip em dashes; reach for commas, semicolons, parentheses, or periods instead.