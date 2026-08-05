############################
# HISTORY
############################

HISTSIZE=100000
SAVEHIST=100000
HISTFILE=$HOME/.zsh_history

setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY
setopt AUTO_CD

############################
# COMPLETION
############################

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

############################
# PATH
############################

export PATH="$HOME/.local/bin:$PATH"

############################
# ALIASES
############################

alias vim="nvim"
alias vi="nvim"

alias fd="fdfind"

alias c="clear"
alias s="tmux-sessionizer"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"

if command -v lazygit >/dev/null; then
    alias lg="lazygit"
fi

if command -v eza >/dev/null; then
    alias ls="eza --icons"
    alias ll="eza -lah --icons"
fi

alias bat="batcat"
alias cat="batcat"

############################
# FZF
############################

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

############################
# ZOXIDE
############################

if command -v zoxide >/dev/null; then
    eval "$(zoxide init zsh)"
fi

############################
# STARSHIP
############################

if command -v starship >/dev/null; then
    eval "$(starship init zsh)"
fi
export PATH=$PATH:$(go env GOPATH)/bin
