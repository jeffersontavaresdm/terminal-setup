#!/bin/bash
# ======================================================================
# Terminal Setup - Installer
# Copies config files to the correct locations
# Usage: bash install.sh
# ======================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GREEN="\033[32m"
YELLOW="\033[33m"
CYAN="\033[36m"
RED="\033[31m"
R="\033[0m"

info()  { echo -e "${CYAN}[INFO]${R}  $1"; }
ok()    { echo -e "${GREEN}[OK]${R}    $1"; }
warn()  { echo -e "${YELLOW}[WARN]${R}  $1"; }
err()   { echo -e "${RED}[ERR]${R}   $1"; }

backup_if_exists() {
    if [ -f "$1" ]; then
        cp "$1" "$1.bak.$(date +%Y%m%d%H%M%S)"
        warn "Backup created: $1.bak.*"
    fi
}

echo ""
echo "================================================"
echo "  Terminal Setup - Installer"
echo "================================================"
echo ""

# --- WezTerm ---
info "Installing WezTerm config..."
mkdir -p ~/.config/wezterm
backup_if_exists ~/.config/wezterm/wezterm.lua
cp "$SCRIPT_DIR/configs/wezterm/wezterm.lua" ~/.config/wezterm/wezterm.lua
ok "WezTerm config installed"

# --- Starship ---
info "Installing Starship config..."
mkdir -p ~/.config
backup_if_exists ~/.config/starship.toml
cp "$SCRIPT_DIR/configs/starship/starship.toml" ~/.config/starship.toml
ok "Starship config installed"

# --- Claude Code statusline ---
info "Installing Claude Code statusline..."
mkdir -p ~/.claude
backup_if_exists ~/.claude/statusline.sh
cp "$SCRIPT_DIR/configs/claude-code/statusline.sh" ~/.claude/statusline.sh
chmod +x ~/.claude/statusline.sh
ok "Claude Code statusline installed"

# --- Claude Code settings (merge statusLine only, don't overwrite hooks) ---
if [ -f ~/.claude/settings.json ]; then
    if command -v jq &> /dev/null; then
        # Merge statusLine and model into existing settings
        TMP=$(mktemp)
        jq -s '.[0] * .[1]' ~/.claude/settings.json "$SCRIPT_DIR/configs/claude-code/settings.json" > "$TMP"
        backup_if_exists ~/.claude/settings.json
        mv "$TMP" ~/.claude/settings.json
        ok "Claude Code settings merged (statusLine + model)"
    else
        warn "jq not found - skipping Claude Code settings merge"
        warn "Manually add statusLine config from configs/claude-code/settings.json"
    fi
else
    cp "$SCRIPT_DIR/configs/claude-code/settings.json" ~/.claude/settings.json
    ok "Claude Code settings installed"
fi

# --- Zsh config ---
info "Installing zsh configs..."
backup_if_exists ~/.zshrc
cp "$SCRIPT_DIR/configs/zsh/zshrc" ~/.zshrc
backup_if_exists ~/.shell_aliases
cp "$SCRIPT_DIR/configs/zsh/shell_aliases" ~/.shell_aliases
ok "Zsh config installed"

echo ""
echo "================================================"
ok "Installation complete!"
echo ""
warn "Review ~/.zshrc and uncomment lines for your OS"
warn "(Homebrew path, ASDF, etc.)"
echo ""
info "Restart your terminal or run: source ~/.zshrc"
echo "================================================"
echo ""
