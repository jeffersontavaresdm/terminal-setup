#!/bin/bash
# RESTORE.sh - Restaura TODAS as configs para o estado anterior
# Uso: bash backup/RESTORE.sh

BACKUP_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Restaurando configuracoes ==="

echo "[1/4] Restaurando .zshrc..."
cp "$BACKUP_DIR/zsh/zshrc.backup" ~/.zshrc

echo "[2/4] Restaurando Powerlevel10k (.p10k.zsh)..."
cp "$BACKUP_DIR/powerlevel10k/p10k.zsh.backup" ~/.p10k.zsh

echo "[3/4] Restaurando Terminator..."
cp "$BACKUP_DIR/terminator/config.backup" ~/.config/terminator/config

echo "[4/4] Restaurando Claude Code settings..."
cp "$BACKUP_DIR/claude-code/settings.json.backup" ~/.claude/settings.json

# Restaurar oh-my-zsh custom (plugins/themes customizados)
if [ -d "$BACKUP_DIR/oh-my-zsh/custom.backup" ]; then
    echo "[extra] Restaurando oh-my-zsh custom..."
    rm -rf ~/.oh-my-zsh/custom
    cp -r "$BACKUP_DIR/oh-my-zsh/custom.backup" ~/.oh-my-zsh/custom
fi

echo ""
echo "=== Restauracao concluida! ==="
echo "Reinicie o terminal ou execute: source ~/.zshrc"
