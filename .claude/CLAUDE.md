## Quick Obligations

| Situation | Required action |
| --- | --- |
| Tool or command hangs | Always write to a tmp file so you can read in chunks without re-running the command. |
| Reviewing git status or diffs | Treat them as read-only; never revert or assume missing changes were yours. |
| Writing a commit | Conventional prefix, lowercase, imperative subject. No body unless the change needs a why. |
| Adding a dependency | Research well-maintained options and confirm fit with the user before adding. |

## Mindset & Process

- *No breadcrumbs*. If you delete or move code, do not leave a comment in the old place. No "// moved to X", no "relocated". Just remove it.
- *Use comments sparingly*. If obvious from the code, do not add a comment.
- Instead of applying a bandaid, fix things from first principles, find the source and fix it versus applying a cheap bandaid on top.
- For non-trivial or architectural work, ground the design in official docs (or papers) and in how the existing codebase already does things before implementing. If the options carry real tradeoffs, ask which I will accept instead of choosing silently. Small, obvious changes go straight to implementing.
- Leave each repo better than how you found it. Fix the code smells inside the diff you are already touching; flag the ones outside it instead of widening the change.
- Clean up unused code ruthlessly. If a function no longer needs a parameter or a helper is dead, delete it and update the callers instead of letting the junk linger.
- *Search before pivoting*. If you are stuck or uncertain, do a quick web search for official docs or specs, then continue with the current approach. Do not change direction unless asked.
- If code is very confusing or hard to understand:
  1. Try to simplify it.
  1. Add an ASCII art diagram in a code comment if it would help.

## Testing Philosophy

- I HATE MOCK tests, either do unit or e2e (with fakes), nothing inbetween. Mocks are lies: they invent behaviors that never happen in production and hide the real bugs that do. If you feel like mocking, ask for permission first.
- Tests must be rigorous enough that a new contributor cannot break existing behavior without a test failing. Cover every behavior the change introduces, sized like the neighboring test files; scratch checks stay out of the repo.
- Unless the user asks otherwise, run only the tests you added or modified instead of the entire suite to avoid wasting time.

## Final Handoff

Before finishing a task:

1. Confirm all touched tests or commands were run and passed (list them if asked).
1. Summarize changes with file and line references.
1. Call out any TODOs, follow-up work, or uncertainties so the user is never surprised later.

## Communication Preferences

- Conversational preference: Try to be funny but not cringe; favor dry, concise, low-key humor. If uncertain a joke will land, do not attempt humor. Avoid forced memes or flattery.
- I prefer explanations in mermaid diagrams over long text.
- If I sound angry, the work missed my expectations. Treat it as a signal to slow down and get the next step right, not as something to apologize for.
- Punctuation preference: Skip em dashes; reach for commas, semicolons, parentheses, or periods instead.