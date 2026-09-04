#!/usr/bin/env bash

set -euo pipefail

# ============================================================
# Dotfiles Package Installer
# ============================================================

if [[ ! -f /etc/os-release ]]; then
    echo "Error: cannot detect Linux distribution."
    exit 1
fi

source /etc/os-release

echo "Detected: ${PRETTY_NAME:-$ID}"

case "${ID:-}" in

    # --------------------------------------------------------
    # Ubuntu / Debian family
    # --------------------------------------------------------

    ubuntu|debian|linuxmint)

        echo
        echo "Installing packages with apt..."

        sudo apt-get update

        sudo apt-get install -y \
            git \
            stow \
            zsh \
            tmux \
            neovim \
            fzf \
            ripgrep \
            fd-find \
            bat \
            curl \
            wget \
            gcc \
            g++ \
            make \
            python3
        ;;

    # --------------------------------------------------------
    # Arch family
    # --------------------------------------------------------

    arch|manjaro|endeavouros)

        echo
        echo "Installing packages with pacman..."

        sudo pacman -Sy --needed --noconfirm \
            git \
            stow \
            zsh \
            tmux \
            neovim \
            fzf \
            ripgrep \
            fd \
            bat \
            curl \
            wget \
            gcc \
            make \
            python
        ;;

    # --------------------------------------------------------
    # Unsupported distribution
    # --------------------------------------------------------

    *)

        echo
        echo "Unsupported Linux distribution:"
        echo "  ${PRETTY_NAME:-$ID}"

        echo
        echo "Supported:"
        echo "  Ubuntu / Debian / Linux Mint"
        echo "  Arch / Manjaro / EndeavourOS"

        exit 1
        ;;

esac

echo
echo "✓ Required packages installed."
