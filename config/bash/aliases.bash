#!/usr/bin/env bash

### enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
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
    ;;
esac

alias delds="find . -name '*.DS_Store' -type f -ls -delete"
alias delap="find . -name '._*' -type f -ls -delete"
alias sed="gsed"

# restart $SHELL
alias rebash='exec $SHELL -l'

# ghq peco hub
alias gcd='cd $(ghq root)/$(ghq list | peco)'
alias ophub='hub browse $(ghq list | peco | cut -d "/" -f 2,3)'
alias vcode='code-insiders $(ghq root)/$(ghq list | peco)'

# virtualenv
alias workoff='deactivate'

# move go project
alias gogo="cd $HOME/go/src/github.com/takuzoo3868"

alias govuls="cd $HOME/go/src/github.com/future-architect"
alias goio="cd $HOME/go/src/github.com/vulsio"
alias gokanbe="cd $HOME/go/src/github.com/kotakanbe"

# tmuxp
alias mux='tmuxp'
alias gomux='tmuxp load ~/.tmux/work.yaml'
alias gouec='set_proxy && tmuxp load ~/.tmux/uec.yaml'
