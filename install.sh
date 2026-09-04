#!/usr/bin/env bash

set -euo pipefail

# ============================================================
# Dotfiles Installer
# ============================================================

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"

echo
echo "================================"
echo "Dotfiles installer"
echo "================================"
echo
echo "Repository: $DOTFILES_DIR"

# ------------------------------------------------------------
# 1. Install required packages
# ------------------------------------------------------------

echo
echo "[1/3] Installing required packages..."

"$DOTFILES_DIR/scripts/install-packages.sh"

# ------------------------------------------------------------
# 2. Prepare and stow configurations
# ------------------------------------------------------------

echo
echo "[2/3] Preparing configurations..."

cd "$DOTFILES_DIR"

packages=(nvim tmux zsh git bin)

for package in "${packages[@]}"; do

    case "$package" in
        nvim)
            target="$HOME/.config/nvim"
            ;;
        tmux)
            target="$HOME/.tmux.conf"
            ;;
        zsh)
            target="$HOME/.zshrc"
            ;;
        git)
            target="$HOME/.gitconfig"
            ;;
        bin)
            target="$HOME/.local/bin/tmux-sessionizer"
            ;;
    esac

    if [[ -e "$target" && ! -L "$target" ]]; then

        echo
        echo "Existing file detected:"
        echo "  $target"

        echo "Backing it up to:"
        echo "  $BACKUP_DIR"

        mkdir -p "$BACKUP_DIR"

        backup_path="$BACKUP_DIR/${target#$HOME/}"

        mkdir -p "$(dirname "$backup_path")"

        mv "$target" "$backup_path"

    fi

done

echo
echo "Stowing configurations..."

stow --restow "${packages[@]}"

echo "✓ Configurations installed"

# ------------------------------------------------------------
# 3. Install external dependencies
# ------------------------------------------------------------

echo
echo "[3/3] Installing external dependencies..."

"$DOTFILES_DIR/scripts/install-dependencies.sh"

# ------------------------------------------------------------
# Done
# ------------------------------------------------------------

echo
echo "================================"
echo "✓ Dotfiles installation complete"
echo "================================"

echo
echo "Managed:"
echo "  ✓ Neovim"
echo "  ✓ Neovim plugins"
echo "  ✓ tmux"
echo "  ✓ tmux plugins"
echo "  ✓ Zsh"
echo "  ✓ Git"
echo "  ✓ Personal scripts"

if [[ -d "$BACKUP_DIR" ]]; then
    echo
    echo "Existing configurations were backed up to:"
    echo "  $BACKUP_DIR"
fi

echo
echo "You can now start programming."
