---
description: Generate a JIRA issue description from requirements or notes
---
Generate a detailed JIRA issue description from the following input:

$ARGUMENTS

Format the output exactly as Markdown and output only the markdown:

## Summary
- Write a clear, concise summary of the goal in 1 to 2 sentences.

## Context / Background
- Explain the context and why this work is needed.

## Technical Details (Optional)
- Include any known technical constraints, implementation suggestions, or relevant endpoints/components when they are implied by the input.

## Acceptance Criteria
- List specific, testable completion criteria.
- Use bullet points or Given/When/Then when appropriate.
- Prefer checklist-style bullets when they fit, for example:
  - [ ] The system should...
  - [ ] When the user clicks X, Y should happen.
