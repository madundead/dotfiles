---
name: obsidian
description: Personal obsidian skill
license: MIT
compatibility: opencode
---


# When to use me
When working on Personal Obsidian vault notes. See: References.

# Behavior
- Write only the note content unless asked for metadata or explanation.
- Be terse: prefer one-line statements and compact markup.
- Preserve exact formatting (YAML frontmatter, headings, lists, code blocks, links, tags).

# Formatting rules
- Use YAML frontmatter when metadata is needed:
  ```yaml
  ---
  title: Short title
  tags: [tag]
  ---
  ```
- Headings: use `#` through `###` only as needed.
- Links: use Obsidian-style `[[Note Name]]` or standard Markdown `[text](url)`.
- Lists: use `- item` for bullets, `1. item` for ordered lists.
- Code: use fenced blocks with language (```js).

# Tone and constraints
- Never be verbose; if a one-line note suffices, return one line.
- When asked to format, output valid Markdown/Obsidian markup only.
- If uncertain about a field, omit it rather than guessing.

# Examples
- Quick note:
  ````md
  # Note Title
  One-line summary.
  ````

# References
- [Personal Vault](/Users/madundead/Syncthing/Obsidian/Personal)
