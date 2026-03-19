# Personal Terminal Setup

Modern terminal configuration: WezTerm + zsh + Starship + Claude Code statusline.

+-------------------------------------------------------------------------------+
|                                   STACK                                       |
+-------------------------------------------------------------------------------+
| Tool                     | Purpose                                            |
|--------------------------|----------------------------------------------------|
| WezTerm                  | GPU-accelerated terminal emulator                  |
| Starship                 | Cross-shell prompt (replaces Powerlevel10k)        |
| zsh + Oh My Zsh          | Shell + plugin framework                           |
| tmux (optional)          | Terminal multiplexer                               |
| JetBrainsMono Nerd Font  | Nerd Font with icons and ligatures                 |
| Claude Code statusline   | Context, git, tokens display                       |
+-------------------------------------------------------------------------------+

+-------------------------------------------------------------------------------+
|                                 STRUCTURE                                     |
+-------------------------------------------------------------------------------+
| configs/            Active configuration files                                |
|   wezterm/          WezTerm config (Lua)                                      |
|   starship/         Starship prompt config (TOML)                             |
|   claude-code/      Claude Code statusline script                             |
|                                                                               |
| prompts/            AI prompts used to generate this setup                    |
|                                                                               |
| backup/             Pre-migration backup (Terminator + p10k + oh-my-zsh)      |
|   RESTORE.sh        One-command rollback to previous setup                    |
+-------------------------------------------------------------------------------+

+-------------------------------------------------------------------------------+
|                              CONFIG LOCATIONS                                 |
+-------------------------------------------------------------------------------+
| Config                      Path                                              |
|-------------------------------------------------------------------------------|
| WezTerm                    | ~/.config/wezterm/wezterm.lua                    |
| Starship                   | ~/.config/starship.toml                          |
| Claude Code statusline     | ~/.claude/statusline.sh                          |
| zshrc                      | ~/.zshrc                                         |
+-------------------------------------------------------------------------------+

+-------------------------------------------------------------------------------+
|                                  ROLLBACK                                     |
+-------------------------------------------------------------------------------+
| bash backup/RESTORE.sh                                                        |
|                                                                               |
+-------------------------------------------------------------------------------+

+-------------------------------------------------------------------------------+
|                             WEZTERM SHORTCUTS                                 |
+-------------------------------------------------------------------------------+
| Action            | Key                                                       |
|-------------------|-----------------------------------------------------------|
| Split horizontal  | Ctrl + Shift + o                                          |
| Split vertical    | Ctrl + Shift + e                                          |
| Navigate panes    | Alt + Arrows                                              |
| Resize panes      | Ctrl + Alt + Arrows                                       |
| Close pane        | Ctrl + Shift + W                                          |
| New tab           | Ctrl + Shift + T                                          |
| Go to tab N       | Alt + 1..5                                                |
+-------------------------------------------------------------------------------+

