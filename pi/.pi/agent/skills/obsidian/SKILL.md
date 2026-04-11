---
name: obsidian
description: Manages Obsidian vault: reading notes, researching topics, updating daily tasks, and project management.
---

# Obsidian Skill

- Vault Root: `~/Syncthing/Obsidian/Personal` (or `~/syncthing/Obsidian/Personal` depending on host OS).
- Vault Structure: Rely on this SKILL.md for quick reads or minor updates. Read `STRUCTURE.md` whenever a task involves creating new files, moving notes between categories, complex organization, or if you need context on formatting and tagging conventions.
- Read Access: Use `grep` or `read` on the entire vault.
- Write/Move Access: Primarily use `00_Inbox/`, `10_Projects/`, and `05_Journal/`. When asked, you may process inbox items into `30_Resources/` or `20_Areas/`, and archive completed projects to `40_Archives/Projects/`.
- Deletion/Bulk limits: Never delete files (move to `99_System/Trash` instead) or bulk-edit (>3 files) without explicit confirmation.
- Hygiene: Ignore `*.sync-conflict-*` files and the `.obsidian/` directory.
- MOC Integrity: When creating a new project in `10_Projects/`, link it in the nearest Map of Content (MOC).
- Asset Storage: Store binary files and PDFs in `99_System/Assets/`.
- Inbox Handling: When asked to add to the inbox, create a new throwaway note in `00_Inbox/` for later processing instead of appending to existing notes.
- Research: When asked to research, use `bash` tools to gather information. Save findings in `00_Inbox/` following the vault's note standards (Context, Content, References) with the `#research` tag.
- Daily Tasks: Update `[x]` in `05_Journal/` notes to sync project progress.
