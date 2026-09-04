# Dotfiles

Personal Linux development environment managed with **GNU Stow**.

This repository contains my configuration for:

- Neovim
- tmux
- Zsh
- Git
- Personal shell scripts
- Neovim plugins
- tmux plugins
- Required system packages
- External development dependencies

The goal is simple:

> Clone this repository on a new Linux machine and restore the development environment with one command.

---

## Installation on a New Machine

### 1. Clone the repository

```bash
git clone https://github.com/jediOTW/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Run the installer

```bash
chmod +x install.sh
./install.sh
```

The installer will:

1. Detect the Linux distribution
2. Install required system packages
3. Back up existing configuration files
4. Stow the dotfiles into `$HOME`
5. Install Neovim dependencies and plugins
6. Install TPM
7. Install tmux plugins

---

## Supported Linux Distributions

The installer currently supports:

- Ubuntu
- Debian
- Linux Mint
- Arch Linux
- Manjaro
- EndeavourOS

---

## What Gets Managed

| Tool               | Managed Location            |
|---------------------|------------------------------|
| Neovim              | `~/.config/nvim`             |
| tmux                | `~/.tmux.conf`                |
| Zsh                 | `~/.zshrc`                    |
| Git                 | `~/.gitconfig`                |
| tmux-sessionizer    | `~/.local/bin/tmux-sessionizer` |

GNU Stow creates symlinks from these locations back to this repository.

For example:

```text
~/.config/nvim
      ↓
~/dotfiles/nvim/.config/nvim
```

---

## After Installation

Restart the shell:

```bash
exec zsh
```

Start Neovim:

```bash
nvim
```

Start tmux:

```bash
tmux
```

The tmux prefix is:

```text
Ctrl-a
```

---

## tmux Sessionizer

The custom tmux-sessionizer script is available through:

```bash
s
```

or:

```bash
tmux-sessionizer
```

It searches `~/projects` for projects and lets you select one using `fzf`.

You can also pass a project directly:

```bash
tmux-sessionizer ~/projects/my-project
```

---

## Neovim

The Neovim configuration is stored in:

```text
nvim/.config/nvim/
```

It includes the complete configuration and the `lazy-lock.json` file used to pin plugin versions.

The installer automatically installs:

- `lazy.nvim`
- Neovim plugins defined by the configuration

Neovim plugins are synchronized automatically during installation.

---

## tmux

The tmux configuration is stored in:

```text
tmux/.tmux.conf
```

It includes:

- Custom prefix
- Mouse support
- Vi-style pane navigation
- Pane resizing
- Split navigation
- Clipboard integration
- Large history buffer

Plugins (via TPM):

- tmux-resurrect
- tmux-continuum
- tmux-yank
- tmux-fzf
- tmux-open
- vim-tmux-navigator
- iSheild integration

---

## Zsh

The Zsh configuration is stored in:

```text
zsh/.zshrc
```

It contains my shell aliases and development environment configuration.

Some useful aliases include:

```text
vim
vi
c
s
gs
ga
gc
gp
gl
bat
cat
..
...
....
```

---

## Git

The Git configuration is stored in:

```text
git/.gitconfig
```

It is restored automatically by GNU Stow.

> **Note:** This file contains personal Git configuration. Review it before using this repository as a template for your own environment.

---

## Personal Scripts

Personal scripts are stored in:

```text
bin/.local/bin/
```

Currently this includes:

- `tmux-sessionizer`

The installer makes it available at:

```text
~/.local/bin/tmux-sessionizer
```

---

## iSheild Integration

The tmux configuration contains optional integration with [iSheild](https://github.com/jediOTW/iSheild).

iSheild provides automatic time-based terminal and tmux themes:

```text
06:00–11:59  Morning
12:00–17:59  Day
18:00–05:59  Night
```

If iSheild is installed at `~/iSheild`, tmux will automatically use its theme switching script.

If iSheild is not installed, the dotfiles installation still works normally.

---

## Backups

The installer never silently overwrites an existing regular configuration file.

If a configuration already exists, it is moved to:

```text
~/.dotfiles-backup/<timestamp>/
```

For example:

```text
~/.dotfiles-backup/20260904-132500/
```

This makes it possible to restore the previous configuration if necessary.

---

## Updating the Environment

Pull the latest dotfiles:

```bash
cd ~/dotfiles
git pull
```

Then re-run the installer:

```bash
./install.sh
```

The installer uses GNU Stow with:

```bash
stow --restow
```

so the configuration symlinks are refreshed automatically.

---

## Repository Structure

```text
dotfiles/
│
├── bin/
│   └── .local/
│       └── bin/
│           └── tmux-sessionizer
│
├── git/
│   └── .gitconfig
│
├── nvim/
│   └── .config/
│       └── nvim/
│           ├── init.lua
│           ├── lazy-lock.json
│           ├── colors/
│           └── lua/
│
├── tmux/
│   └── .tmux.conf
│
├── zsh/
│   └── .zshrc
│
├── scripts/
│   ├── install-packages.sh
│   └── install-dependencies.sh
│
├── .gitignore
├── install.sh
└── README.md
```

---

## Installation Flow

The complete installation flow is:

```text
New Linux Machine
       │
       ▼
    git clone
       │
       ▼
    ~/dotfiles
       │
       ▼
    ./install.sh
       │
       ├── Install system packages
       │
       ├── Backup existing configs
       │
       ├── GNU Stow
       │      │
       │      ├── Neovim
       │      ├── tmux
       │      ├── Zsh
       │      ├── Git
       │      └── Personal scripts
       │
       ├── Install lazy.nvim
       │
       ├── Install Neovim plugins
       │
       ├── Install TPM
       │
       └── Install tmux plugins
       │
       ▼
  Ready to Code
```

---

## Manual Stow Commands

If you only want to update a specific configuration:

**Neovim**

```bash
cd ~/dotfiles
stow --restow nvim
```

**tmux**

```bash
cd ~/dotfiles
stow --restow tmux
```

**Zsh**

```bash
cd ~/dotfiles
stow --restow zsh
```

**Git**

```bash
cd ~/dotfiles
stow --restow git
```

**Personal scripts**

```bash
cd ~/dotfiles
stow --restow bin
```

---

## Removing a Configuration

To remove a Stow-managed configuration:

```bash
cd ~/dotfiles
stow --delete nvim
```

For example:

```bash
stow --delete tmux
```

This removes the symlink managed by Stow without deleting the files inside the repository.

---

## Philosophy

This repository is intentionally focused on reproducibility and low cognitive load.

A new machine should not require manually remembering:

- Which packages to install
- Where configuration files belong
- Which Neovim plugins to install
- Which tmux plugins to install
- Which scripts need to be copied
- Which configuration files need to be symlinked

The desired workflow is:

```bash
git clone https://github.com/jediOTW/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Then:

```bash
exec zsh
```

and start working.

---

## Notes

This is a personal development environment rather than a universal Linux configuration.

Some settings may depend on my preferred workflow, tools, directory structure, or development environment.

If you fork this repository, review the configuration before using it as your own dotfiles setup.