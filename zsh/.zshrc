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

# Live terminal title

# Live terminal title
function update_terminal_title_state() {
  print -r -- "${PWD:t}" > "$TERMINAL_TITLE_STATE_FILE"
}

function cleanup_terminal_title() {
  if [[ -n ${TERMINAL_TITLE_PID:-} ]]; then
    kill "$TERMINAL_TITLE_PID" 2>/dev/null
  fi

  [[ -n ${TERMINAL_TITLE_STATE_FILE:-} ]] &&
    rm -f "$TERMINAL_TITLE_STATE_FILE"
}

autoload -Uz add-zsh-hook

# Prevent duplicate background processes when reloading .zshrc
cleanup_terminal_title

TERMINAL_TITLE_STATE_FILE=$(mktemp "${TMPDIR:-/tmp}/zsh-title.XXXXXX")

add-zsh-hook -d precmd update_terminal_title_state
add-zsh-hook precmd update_terminal_title_state

add-zsh-hook -d zshexit cleanup_terminal_title
add-zsh-hook zshexit cleanup_terminal_title

(
  state_file="$TERMINAL_TITLE_STATE_FILE"

  while [[ -r "$state_file" ]]; do
    IFS= read -r current_dir < "$state_file"

    battery_text="N/A"

    for battery_dir in /sys/class/power_supply/BAT*(N); do
      if [[ -r "$battery_dir/capacity" ]]; then
        IFS= read -r battery_level < "$battery_dir/capacity"
        battery_text="${battery_level}%"
        break
      fi
    done

    current_date=$(date '+%Y-%m-%d')
    current_time=$(date '+%H:%M:%S')

    printf '\e]0;⌁ Zsh │ %s │   %s │ 📅 %s │ ◷ %s\a' \
      "$current_dir" "$battery_text" "$current_date" "$current_time" \
      > /dev/tty

    sleep 1
  done
) &!

TERMINAL_TITLE_PID=$!

