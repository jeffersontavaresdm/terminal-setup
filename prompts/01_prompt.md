You are an expert in Claude Code CLI customization and terminal UX.

Your task is to configure a custom statusline for Claude Code that improves visibility and usability.

GOALS:
- Show current working directory
- Show current git branch (if inside a repo)
- Show Claude session usage (context/token usage)
- Make it visually clear and minimal (no clutter)
- Ensure it updates in real time (no manual commands like /usage)

CONSTRAINTS:
- Do NOT break existing shell configuration (zsh + powerlevel10k already in use)
- Prefer using Oh My Posh if available; otherwise install and configure it
- All configuration must be persistent (saved to config files)
- Keep everything lightweight and fast

STEPS:
1. Check if `oh-my-posh` is installed
   - If not, install it in a standard way for Linux

2. Create a config file at:
   ~/.claude.omp.json

3. Configure the statusline to include:
   - Current directory
   - Git branch
   - Claude usage (context/token)
   - Clean separators and readable formatting

4. Update Claude Code config to use this statusline:
   - Configure statusLine to execute:
     oh-my-posh claude --config ~/.claude.omp.json

5. Validate:
   - Confirm the statusline is rendering
   - Confirm git branch appears inside a repo
   - Confirm usage/context is visible

6. If something fails:
   - Debug and fix automatically

OUTPUT:
- Show what was created/modified
- Explain briefly how to tweak colors or sections later
- Keep explanation concise

