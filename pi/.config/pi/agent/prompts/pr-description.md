---
description: Generate a GitHub PR description for the current branch
---
Generate a GitHub pull request description for the current branch.

Requested base branch: $1

Instructions:
- Determine the current branch name.
- Compare the current branch against the requested base branch.
- If no base branch was provided, prefer `main`, then `master`, then the repo's default branch.
- Inspect the actual git diff yourself before writing.
- If an issue identifier such as `#123` or `ABC-456` appears in the branch name, mention it in Related Issues. Otherwise use `[Optional: Insert Issue Link Here]`.

Format the output exactly like this Markdown template. Wrap the entire output in a markdown code block (```markdown) to ensure it is treated as raw text when viewed or copied, preventing premature rendering. Output only the code block containing the markdown.

## Description
- Start with a high-level summary in 2 to 3 sentences.
- If needed, add a deeper explanation, but keep the whole section to no more than 8 sentences.
- Keep the tone professional, concise, and focused on business value or the technical fix.

## Related Issues
- Include one line for an issue link or placeholder.

## Additional Notes
- Write 1 to 2 sentences explaining what changed and why.
- If there are important technical details such as config changes, new dependencies, or refactors, list them as bullet points.

## Checklist
- [ ] I have ensured that the pull request is of a manageable size, allowing it to be reviewed within a single session.
- [ ] I have reviewed my changes to ensure they are clear, concise, and well-documented.
- [ ] I have updated the documentation, if applicable.
- [ ] I have added or updated test cases to cover my changes, if applicable.
