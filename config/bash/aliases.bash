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

### OS-specific configurations
case "${OSTYPE}" in
    linux*)
        alias ll='ls -alF'
        alias la='ls -A'
        alias l='ls -CF'

        # Cross-platform clipboard muscle memory for Linux
        if command -v xclip >/dev/null 2>&1; then
            alias pbcopy='xclip -selection clipboard'
            alias pbpaste='xclip -selection clipboard -o'
        fi
        ;;
    darwin*)
        # Prefer GNU coreutils (gls) if installed for better color support
        if command -v gls >/dev/null 2>&1; then
            alias ls='gls --color=auto'
            alias ll='gls -alF --color=auto'
            alias la='gls -A --color=auto'
            alias l='gls -CF --color=auto'
        else
            # Fallback to macOS default ls (BSD)
            export LSCOLORS="Exfxcxdxbxegedabagacad"
            alias ls='ls -G'
            alias ll='ls -alFG'
            alias la='ls -AG'
            alias l='ls -CFG'
        fi
        alias sed="gsed"
        # macOS specific utilities
        alias flushdns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
        alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder'
        alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder'
        ;;
esac

### Add an "alert" alias for long running commands.  Use like so:
#sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

### Remove garbage files
alias delds="find . -name '*.DS_Store' -type f -ls -delete"
alias delap="find . -name '._*' -type f -ls -delete"

### Restart current shell
alias rebash='exec $SHELL -l'
alias rezsh='exec $SHELL -l'

### ghq & fzf integration
alias gcd='cd $(ghq root)/$(ghq list | fzf --reverse)'

### tmuxp configurations
alias mux='tmuxp'
alias gomux='tmuxp load ~/.tmux/work.yaml'

### Archive extractor
# Usage: extract <file>
extract () {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.tar.xz)    tar xJf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xf "$1"      ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.Z)         uncompress "$1"  ;;
            *.7z)        7za x "$1"       ;;
            *.xz)        xz -d "$1"       ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}
