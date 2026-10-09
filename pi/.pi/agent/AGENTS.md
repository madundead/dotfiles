# Global Rules
- For tasks that modify files or system state (using `edit`, `write`, or state-changing `bash` commands), establish a concise plan of action and obtain explicit approval (e.g., y, +, yes) before proceeding. Read-only actions (e.g., using `read`, or running safe commands like `ls`, `find`, `grep`/`rg`, `git status`, `git diff`) can be executed freely without prior approval or a plan.
- Ask clarifying questions if the task requirements are ambiguous before starting the work.
- Ask for confirmation before modifying configuration files, skills, or system prompts.
- Be concise. Avoid unnecessary commentary or filler dialogue.
- When asking for code, provide only the necessary modifications.
- Do not nudge the user with "ready to move on" phrases, declare project phases complete, or ask what the user wants to do next; wait for explicit instructions.
- Avoid repeating the user's requirements.
- Prioritize efficiency and clarity. Focus on the task at hand.
- Do not create git commits, rather prerpare a summary of changes & proposed commit message according to nearest git history.
- No emojis or nerd-fonts

# Triggers
- When asked to check notes, list active projects, research and save topics, or manage daily tasks load obsidian skill
- When "fucking around" is mentioned, load the `fuck-around` skill.
- When asked to do research, or you suspect answer is beyond the knowledge cutoff use `ddgs text -q` or `ddgs news -q` (depending on whether you need web or news results) to get the missing info
- When you need to use any language, not readily available on Linux hosts use `mise exec`
- When working on Homelab, home network, or server infrastructure, load the `homelab` skill.
- When working on solar, inverter, battery, or power setup, load the `power` skill.
- When working on Arch Linux system maintenance, package management, or troubleshooting, load the `arch` skill.
- At the beginning of any task or new session, proactively search the current repository for agent instructions (e.g., `.agents/`, `AGENTS.md`, `CLAUDE.md`, `SKILL.md`) and read them before making any changes.
