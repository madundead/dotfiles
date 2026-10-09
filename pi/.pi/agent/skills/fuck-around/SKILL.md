---
name: fuck-around
description: Initialize or resume a "fucking around" session for unstructured exploration and tinkering.
---

# Fuck Around

Always load the `obsidian` skill alongside this one.

## Trigger

This skill activates when the user says "fucking around" or similar phrases indicating an open-ended tinkering session.

## Workflow

1. Load the `obsidian` skill.
2. Search `10_Projects/` in the vault for an existing active `Fucking Around` note (tagged `type/fucking-around` in YAML frontmatter).
3. If one exists, resume it — read the current tasks and log, then ask the user what they want to focus on. Immediately populate the note with whatever the user says.
4. If none exists, create a new one using `99_System/Templates/Fucking Around.md` in `10_Projects/`, then ask the user what they want to focus on. Immediately populate the note with whatever the user says.
5. When the user signals the session is done, archive the note:
   - Change `status/active` to `status/done` in the frontmatter.
   - Move the note from `10_Projects/` to `40_Archives/Projects/`.
   - Add a final log entry with the session end time.

## Template location

`99_System/Templates/Fucking Around.md` in the Obsidian vault contains the frontmatter and structure for session notes.
