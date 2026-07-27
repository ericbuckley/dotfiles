---
description: Generate a shell command that answers a natural-language question
argument-hint: "<question>"
---
Translate the following question into one shell command that answers it:

$1

Requirements:
- Target zsh on macOS, using portable Unix commands where practical.
- Output exactly one command. It may contain pipelines or a compound shell expression.
- Output only the command, with no prose, markdown, or code fences.
- Prefer read-only inspection commands. Do not modify files or system state unless the question explicitly requests it.
- Do not use `sudo`, destructive operations, or downloaded code unless explicitly requested.
- Quote paths, patterns, and variables safely.
- Make reasonable assumptions when needed rather than explaining them.
