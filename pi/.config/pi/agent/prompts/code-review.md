---
description: Review code changes as a senior engineer
---
Review the following code changes as a senior engineer performing a thorough code review.

Diff arguments (passed directly to `git diff`): $@

Instructions:
- Run `git diff $@` yourself with `-U10` context lines (or fewer if the diff is very large) to inspect the changes.
- If no arguments are provided, default to reviewing unstaged changes (`git diff`).
- Read any relevant surrounding files when you need more context to give a useful review.

Focus areas:
- Architecture and design decisions
- Potential bugs and edge cases
- Performance considerations
- Security implications
- Code maintainability and best practices
- Test coverage gaps

Output format — use this structure, in markdown:

## Summary
2–3 sentences describing what this change does and why.

## Strengths
Brief bullet list of what is done well.

## Issues
Ordered by priority (critical → minor). For each issue:
- **[Severity]** Description of the problem
- Suggested fix or code example if applicable

## Nits
Optional low-priority style or cleanup suggestions.

Be specific, constructive, and actionable. Output only the review in markdown with no preamble.
