#!/usr/bin/env bash

set -euo pipefail

# ============================================================
# Dotfiles Dependency Installer
# ============================================================

echo
echo "Installing external dependencies..."

# ------------------------------------------------------------
# 1. Neovim — lazy.nvim
# ------------------------------------------------------------

LAZY_DIR="$HOME/.local/share/nvim/lazy/lazy.nvim"
LAZY_REPO="https://github.com/folke/lazy.nvim.git"
LAZY_COMMIT="306a05526ada86a7b30af95c5cc81ffba93fef97"

if [[ ! -d "$LAZY_DIR/.git" ]]; then

    echo
    echo "Installing lazy.nvim..."

    mkdir -p "$(dirname "$LAZY_DIR")"

    git clone "$LAZY_REPO" "$LAZY_DIR"

    git -C "$LAZY_DIR" checkout "$LAZY_COMMIT"

    echo "✓ lazy.nvim installed"

else

    echo "✓ lazy.nvim already installed"

fi

# ------------------------------------------------------------
# 2. Neovim plugins
# ------------------------------------------------------------

echo
echo "Installing Neovim plugins..."

nvim --headless "+Lazy! sync" "+qa"

echo "✓ Neovim plugins installed"

# ------------------------------------------------------------
# 3. tmux — TPM
# ------------------------------------------------------------

TPM_DIR="$HOME/.tmux/plugins/tpm"
TPM_REPO="https://github.com/tmux-plugins/tpm"

if [[ ! -d "$TPM_DIR/.git" ]]; then

    echo
    echo "Installing TPM..."

    mkdir -p "$(dirname "$TPM_DIR")"

    git clone "$TPM_REPO" "$TPM_DIR"

    echo "✓ TPM installed"

else

    echo "✓ TPM already installed"

fi

# ------------------------------------------------------------
# 4. tmux plugins
# ------------------------------------------------------------

echo
echo "Installing tmux plugins..."

"$TPM_DIR/bin/install_plugins"

echo "✓ tmux plugins installed"

# ------------------------------------------------------------
# Done
# ------------------------------------------------------------

echo
echo "✓ External dependencies installed."
