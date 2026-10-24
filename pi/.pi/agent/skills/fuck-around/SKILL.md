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
   - Keep the existing log **as-is**. It is the recall record; do not compress or rewrite past entries.

## Log format

Keep the note scannable for a human while still useful for an agent resuming the session. The log is also the recall record, so it is **never compacted** on archive.

- **Newest entry first**, directly under `## Log`. The most recent state is what a resuming reader needs.
- One line per event, about 200 characters max: `- **YYYY-MM-DD HH:MM** <object>: <outcome> → [[Note]]`
- Timestamps come from `date +"%Y-%m-%d %H:%M"`. Run it before writing an entry; never fill a timestamp in from memory.
- Detail lives in notes, not in the log. If an entry needs more than two lines, write it to an `00_Inbox/` note — or append to the area note that already owns the topic — and link it instead of restating it.
- At most two nested child lines per event, and only these labels:
    - `**Decision**: <the choice, one line>` when a choice was made
    - `**Rejected**: <option> — <why>` when something was considered and ruled out

## Template location

`99_System/Templates/Fucking Around.md` in the Obsidian vault contains the frontmatter and structure for session notes.
