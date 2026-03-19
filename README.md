# Terminal Setup

Modern terminal setup: **WezTerm** + **Zsh** + **Starship** + **Claude Code statusline**.

Works on **Linux**, **macOS** and **Windows** (WSL).

```
┌────────────────────────────────────────────────────────────────────┐
│  Gruvbox Dark theme · MesloLGS NF · 100% opacity                   │
│  Starship prompt · Git-aware · Claude Code context bar             │
└────────────────────────────────────────────────────────────────────┘
```

---

## Stack

| Tool                    | Role                                    |
|-------------------------|-----------------------------------------|
| WezTerm                 | GPU-accelerated terminal emulator       |
| Starship                | Cross-shell prompt                      |
| Zsh + Oh My Zsh         | Shell + plugin framework                |
| JetBrainsMono Nerd Font | Font with icons and ligatures           |
| Claude Code statusline  | Context window, git, tokens display     |
| zoxide                  | Smart `cd` (learns your directories)    |
| fzf                     | Fuzzy finder for interactive selection  |
| exa                     | Modern `ls` replacement with icons      |
| bat                     | `cat` with syntax highlighting          |
| ripgrep                 | Fast `grep` replacement                 |

---

## Quick Install

```bash
# 1. Install dependencies (see detailed instructions below)
# 2. Clone this repo
git clone https://github.com/jeffersontavaresdm/terminal-setup.git
cd terminal-setup

# 3. Run the installer
bash install.sh

# 4. Review ~/.zshrc and uncomment lines for your OS
# 5. Restart your terminal
```

---

## Step-by-step Installation

### 1. Install WezTerm

<details>
<summary><strong>Linux (Ubuntu/Debian)</strong></summary>

```bash
# Flatpak (recommended)
flatpak install flathub org.wezfurlong.wezterm

# Or via .deb package
curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /etc/apt/keyrings/wezterm-fury.gpg
echo 'deb [signed-by=/etc/apt/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
sudo apt update && sudo apt install wezterm
```

</details>

<details>
<summary><strong>macOS</strong></summary>

```bash
brew install --cask wezterm
```

</details>

<details>
<summary><strong>Windows</strong></summary>

```powershell
winget install wez.wezterm
# Or download from: https://wezfurlong.org/wezterm/install/windows.html
```

> On Windows, WezTerm config goes to `%USERPROFILE%\.config\wezterm\wezterm.lua`
> or `%USERPROFILE%\.wezterm.lua`.

</details>

---

### 2. Install JetBrainsMono Nerd Font

<details>
<summary><strong>Linux</strong></summary>

```bash
# Download and install
mkdir -p ~/.local/share/fonts
cd /tmp
curl -fLO https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz
tar -xf JetBrainsMono.tar.xz -C ~/.local/share/fonts/
fc-cache -fv
```

</details>

<details>
<summary><strong>macOS</strong></summary>

```bash
brew install --cask font-jetbrains-mono-nerd-font
```

</details>

<details>
<summary><strong>Windows</strong></summary>

1. Download from [Nerd Fonts releases](https://github.com/ryanoasis/nerd-fonts/releases/latest) (`JetBrainsMono.tar.xz`)
2. Extract and select all `.ttf` files → Right-click → **Install for all users**

Or via Chocolatey:
```powershell
choco install nerd-fonts-jetbrainsmono
```

</details>

---

### 3. Install Zsh + Oh My Zsh

<details>
<summary><strong>Linux (Ubuntu/Debian)</strong></summary>

```bash
# Install zsh
sudo apt install zsh

# Set as default shell
chsh -s $(which zsh)

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

</details>

<details>
<summary><strong>macOS</strong></summary>

```bash
# zsh is the default shell on macOS, just install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install plugins
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

</details>

<details>
<summary><strong>Windows (WSL)</strong></summary>

```bash
# Inside WSL (Ubuntu)
sudo apt install zsh
chsh -s $(which zsh)

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

> On Windows native (without WSL), use WezTerm + PowerShell with Starship instead of Zsh.

</details>

---

### 4. Install Starship

<details>
<summary><strong>Linux / macOS / WSL</strong></summary>

```bash
curl -sS https://starship.rs/install.sh | sh
```

</details>

<details>
<summary><strong>macOS (Homebrew)</strong></summary>

```bash
brew install starship
```

</details>

<details>
<summary><strong>Windows (PowerShell)</strong></summary>

```powershell
winget install Starship.Starship

# Add to PowerShell profile (~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1):
# Invoke-Expression (&starship init powershell)
```

</details>

---

### 5. Install CLI Tools

<details>
<summary><strong>Linux (Ubuntu/Debian)</strong></summary>

```bash
sudo apt install fzf ripgrep bat
# exa is deprecated, use eza:
sudo apt install eza
# Or via cargo: cargo install eza

# zoxide
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# jq (needed for Claude Code statusline)
sudo apt install jq bc
```

> On Ubuntu, `bat` is installed as `batcat`. The aliases in this setup already use `batcat`.
> If your distro installs it as `bat`, update the aliases accordingly.

</details>

<details>
<summary><strong>macOS</strong></summary>

```bash
brew install fzf ripgrep bat eza zoxide jq bc
```

> On macOS, `bat` is just `bat` (not `batcat`). Update aliases:
> ```bash
> alias b='bat'
> alias bb='bat --paging=never'
> ```

</details>

<details>
<summary><strong>Windows (WSL)</strong></summary>

Same as Linux instructions above, inside WSL.

</details>

---

### 6. Install Claude Code

```bash
# Install Claude Code CLI
npm install -g @anthropic-ai/claude-code

# First run to authenticate
claude
```

---

### 7. Apply Configs

Run the installer to copy all configs to the right places:

```bash
cd terminal-setup
bash install.sh
```

Or manually copy:

```bash
# WezTerm
mkdir -p ~/.config/wezterm
cp configs/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua

# Starship
cp configs/starship/starship.toml ~/.config/starship.toml

# Zsh
cp configs/zsh/zshrc ~/.zshrc
cp configs/zsh/shell_aliases ~/.shell_aliases

# Claude Code statusline
mkdir -p ~/.claude
cp configs/claude-code/statusline.sh ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh

# Claude Code settings (statusline + model)
# If you already have settings.json, merge manually:
# Add "statusLine" and "model" keys from configs/claude-code/settings.json
cp configs/claude-code/settings.json ~/.claude/settings.json
```

After copying, edit `~/.zshrc` and uncomment the lines for your OS (Homebrew path, ASDF, etc.).

---

## Config Locations

| Config                 | Path                              |
|------------------------|-----------------------------------|
| WezTerm                | `~/.config/wezterm/wezterm.lua`   |
| Starship               | `~/.config/starship.toml`        |
| Zsh                    | `~/.zshrc`                       |
| Aliases                | `~/.shell_aliases`               |
| Claude Code statusline | `~/.claude/statusline.sh`        |
| Claude Code settings   | `~/.claude/settings.json`        |

---

## Project Structure

```
terminal-setup/
├── configs/
│   ├── wezterm/
│   │   └── wezterm.lua            # WezTerm config (Gruvbox Dark, keybindings)
│   ├── starship/
│   │   └── starship.toml          # Starship prompt (git-aware, minimal)
│   ├── zsh/
│   │   ├── zshrc                  # Zsh config (Oh My Zsh + plugins + Starship)
│   │   └── shell_aliases          # Shell aliases (git, exa, bat, fzf)
│   └── claude-code/
│       ├── statusline.sh          # Claude Code statusline script
│       └── settings.json          # Claude Code settings (statusline + model)
├── backup/                        # Pre-migration backup (Terminator + p10k)
│   └── RESTORE.sh                 # Rollback to previous setup
├── install.sh                     # Automated installer
└── README.md
```

---

## Theme & Colors

This setup uses **Catppuccin Mocha** everywhere:

| Element           | Color                           |
|-------------------|---------------------------------|
| Color scheme      | Gruvbox Dark (WezTerm)          |
| Background        | 100% opacity (solid)            |
| Font              | MesloLGS NF Bold 12pt           |
| Prompt symbol     | Green `❯` (red on error)        |
| Directory         | Bold cyan                       |
| Git branch        | Bold purple                     |
| Git status        | Bold red                        |
| Command duration  | Bold yellow                     |
| Cursor            | Blinking underline, 500ms       |

---

## WezTerm Shortcuts

| Action           | Key                    |
|------------------|------------------------|
| Split vertical   | `Ctrl+Shift+O`         |
| Split horizontal | `Ctrl+Shift+E`         |
| Navigate panes   | `Alt+Arrows`           |
| Resize panes     | `Ctrl+Alt+Arrows`      |
| Close pane       | `Ctrl+Shift+W`         |
| New tab          | `Ctrl+Shift+T`         |
| Go to tab N      | `Alt+1..5`             |
| Search           | `Ctrl+Shift+F`         |
| Font size +/-    | `Ctrl+=` / `Ctrl+-`    |
| Font size reset  | `Ctrl+0`               |

---

## Claude Code Statusline

The statusline shows real-time session info at the bottom of Claude Code:

```
  ~/dev/project │  main │ Opus 4.6 (1M context)
  ctx 23% of 1M ██░░░░░░░░ │ ↑12.3k ↓4.5k │ session 5m32s
```

- **Line 1:** Working directory, git branch, model name
- **Line 2:** Context window usage (color-coded bar), token counts, session duration

Context bar colors:
- Green: < 50%
- Yellow: 50-75%
- Orange: 75-90%
- Red: > 90%

---

## Zsh Plugins

| Plugin                    | What it does                              |
|---------------------------|-------------------------------------------|
| git                       | Git aliases and functions (Oh My Zsh)     |
| zsh-syntax-highlighting   | Command syntax coloring as you type       |
| zsh-autosuggestions       | Fish-like suggestions from history        |
| bgnotify                  | Desktop notification on long commands     |
| command-not-found         | Suggests package to install               |

---

## Windows Notes

On Windows **without WSL**, you can still get most of this setup:

1. Install **WezTerm** and copy `wezterm.lua` to `%USERPROFILE%\.config\wezterm\`
2. Install **Starship** and configure it for **PowerShell**:
   ```powershell
   # In ~\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
   Invoke-Expression (&starship init powershell)
   ```
3. Copy `starship.toml` to `%USERPROFILE%\.config\starship.toml`
4. Install **Claude Code** via npm and configure the statusline

For the full Zsh experience on Windows, use **WSL** (Windows Subsystem for Linux).

---

## Rollback

To restore the previous setup (Terminator + Powerlevel10k):

```bash
bash backup/RESTORE.sh
```
