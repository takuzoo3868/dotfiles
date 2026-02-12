#!/usr/bin/env bash

### enable color support of ls and also add handy aliases
if command -v dircolors >/dev/null 2>&1; then
    if [ -r "$HOME/.dircolors" ]; then
        eval "$(dircolors -b "$HOME/.dircolors")"
    else
        eval "$(dircolors -b)"
    fi

    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias grepF='grep -F --color=auto'
    alias grepE='grep -E --color=auto'
fi

### Add an "alert" alias for long running commands.  Use like so:
#sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

case "${OSTYPE}" in
linux*)
    alias ll='ls -alF --color=auto'
    alias la='ls -A --color=auto'
    alias l='ls -CF --color=auto'
    ;;
darwin*)
    alias ll='ls -alFG --color=auto'
    alias la='ls -AG'
    alias l='ls -CFG'
    alias sed="gsed"
    ;;
esac

alias delds="find . -name '*.DS_Store' -type f -ls -delete"
alias delap="find . -name '._*' -type f -ls -delete"

# restart $SHELL
alias rebash='exec $SHELL -l'
alias rezsh='exec $SHELL -l'

# ghq fzf
alias gcd='cd $(ghq root)/$(ghq list | fzf --reverse)'

# tmuxp
alias mux='tmuxp'
alias gomux='tmuxp load ~/.tmux/work.yaml'
