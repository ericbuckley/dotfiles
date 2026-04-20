---
description: Generate a conventional commit message from staged git changes
---
Review the currently staged git changes and write a commit message that follows the Conventional Commits 1.0.0 specification.

Requirements:
- Inspect the staged changes yourself using git tools.
- Choose the most appropriate type from: feat, fix, refactor, perf, style, test, docs, build, ops, chore.
- An optional scope may be used when it clarifies the change.
- Use `!` only for breaking changes.
- The subject line must be imperative, present tense, lowercase at the start, no trailing period, and no more than 50 characters.
- Add a body when it helps explain motivation, context, or previous behavior.
- Wrap body lines at about 72 characters.
- If the change is breaking, include a `BREAKING CHANGE:` footer.

Output only the final commit message with no commentary or code fences.
