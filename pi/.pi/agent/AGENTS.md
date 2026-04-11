# Global Rules
- Be concise. Avoid unnecessary commentary or filler dialogue.
- When asking for code, provide only the necessary modifications.
- If the user asks for a feature, implement it directly. Avoid repeating the user's requirements.
- Prioritize efficiency and clarity. Focus on the task at hand.
- Ask for confirmation before modifying configuration files, skills, or system prompts.
- Do not create git commits, rather prerpare a summary of changes & proposed commit message according to nearest git history.

# Triggers
- When asked to check notes, list active projects, research and save topics, or manage daily tasks load obsidian skill
- When asked to do research, or you suspect answer is beyond the knowledge cutoff use bash tools (like `ddgr` or `curl`) to get the missing info
- When you need to use any language, not readily available on Linux hosts use `mise exec`
- At the beginning of any task or new session, proactively search the current repository for agent instructions (e.g., `.agents/`, `AGENTS.md`, `CLAUDE.md`, `SKILL.md`) and read them before making any changes.
