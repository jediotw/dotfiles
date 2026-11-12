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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm
export PNPM_HOME="/home/saurabh/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
. "$HOME/.deno/env"

# opencode
export PATH="$HOME/.opencode/bin:$PATH"

# Far Manager-inspired terminal status title
function set_terminal_title() {
  local battery_text="BAT N/A"
  local battery_dir

  # Battery percentage
  for battery_dir in /sys/class/power_supply/BAT*(N); do
    if [[ -r "$battery_dir/capacity" ]]; then
      local battery_level
      IFS= read -r battery_level < "$battery_dir/capacity"
      battery_text="BAT ${battery_level}%"
      break
    fi
  done

  # System uptime
  local uptime_seconds
  IFS=' ' read -r uptime_seconds _ < /proc/uptime
  local -i total_seconds=${uptime_seconds%%.*}
  local -i days=$((total_seconds / 86400))
  local -i hours=$((total_seconds % 86400 / 3600))
  local -i minutes=$((total_seconds % 3600 / 60))

  local uptime_text
  if (( days > 0 )); then
    uptime_text="UP ${days}d ${hours}h"
  else
    uptime_text="UP ${hours}h${minutes}m"
  fi

  # 24-hour clock
  local current_time
  current_time=$(date '+%H:%M:%S')

  # Update terminal title
  printf '\e]0;Zsh | %s | %s | %s | %s\a' \
    "${PWD:t}" "$battery_text" "$uptime_text" "$current_time"
}

autoload -Uz add-zsh-hook
add-zsh-hook -d precmd set_terminal_title
add-zsh-hook precmd set_terminal_title
