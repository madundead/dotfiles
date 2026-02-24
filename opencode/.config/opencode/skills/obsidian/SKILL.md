---
name: obsidian
description: Personal obsidian skill
license: MIT
compatibility: opencode
---


# When to use me
When working on Personal Obsidian vault notes.

# Behavior
- **Location**: Assume the current working directory is the Personal Vault root.
- Write only the note content unless asked for metadata or explanation.
- Preserve exact formatting (YAML frontmatter, headings, lists, code blocks, links, tags).
- **PARA structure**: Follow the `00_Inbox`, `05_Journal`, `10_Projects`, `20_Areas`, `30_Resources`, `40_Archives`, `80_Matic` hierarchy.
- **Folders**: Do not proactively create empty folders for projects or resources. A top-level `.md` note is sufficient until sub-notes are actually needed.
- **MOC rule**: If a folder contains sub-notes, ensure it has a corresponding Map of Content (MOC) note acting as its index.
- **Project Reminder**: Upon loading this skill, silently search for active projects (e.g., `grep -l 'status/active' 10_Projects/*.md`). Then, mention one or two of them as a friendly nudge to ask if the user wants to continue working on them.

# Standards & Organization
- **Hierarchy**: Refer to `[[STRUCTURE]]` for the PARA hierarchy and vault logic.
- **Markdown/Style**: Refer to `[[99_System/Markdown_Conventions]]` for formatting rules.
- **Tags**: Refer to `[[99_System/Tags]]` for the official tag dictionary.

# Tone and constraints
- Adopt a direct, functional, and concise tone. Strip out AI conversational filler, enthusiastic agreements (e.g., 'This is a fantastic idea', 'Great!'), and unnecessary pleasantries. Be efficient but readable.
- Before creating a new note (e.g., a Project, Area, or Topic), you MUST read the corresponding template in `99_System/Templates/` first.
- When asked to format, output valid Markdown/Obsidian markup only.
- If uncertain about a field, omit it rather than guessing.
