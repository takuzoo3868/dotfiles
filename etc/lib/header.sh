#!/usr/bin/env bash

# Author: takuzoo3868
# Last Modified: 08 Jun 2018.

# use colors on terminal
tput=$(which tput)
if [ -n "$tput" ]; then
  ncolors=$($tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi

### functions
# info: output terminal green
info() { 
  printf "${GREEN}"
  echo -n "[+] "
  printf "${NORMAL}"
  echo "$1"
}
# error: output terminal red
error() {
  printf "${RED}"
  echo -n "[-] "
  printf "${NORMAL}"
  echo "$1"
}
# warn: output terminal yellow
warn() {
  printf "${YELLOW}"
  echo -n "[*] "
  printf "${NORMAL}"
  echo "$1"
}
# log: out put termial normal
log() { 
  echo "  $1" 
}


# fix sed command diff between GNU & BSD
if sed --version 2>/dev/null | grep -q GNU; then
  alias sedi='sed -i '
else
  alias sedi='sed -i "" '
fi

# check package & return flag
is_exists() {
    which "$1" >/dev/null 2>&1
    return $?
}

# check bash version
is_bash() {
    [ -n "$BASH_VERSION" ]
}

# check package
has() {
  type "$1" > /dev/null 2>&1
}

# create symlink
symlink() {
  [ -e "$2" ] || ln -sf "$1" "$2"
}

# install lang
install_langenv(){
  if is_exists "anyenv"; then
    if ! is_exists "goenv"; then
      anyenv install goenv
    fi
    if ! is_exists "pyenv"; then
      anyenv install pyenv
    fi
    if ! is_exists "jenv"; then
      anyenv install jenv
    fi
    if ! is_exists "rbenv"; then
      anyenv install rbenv
    fi
    sleep 2
  else
    error "anyenv not found."
    exit
  fi
}

install_python(){
  if is_exists "pyenv"; then
    if [ ! -d "$HOME/.anyenv/envs/pyenv/versions/2.7.15" ]; then
      pyenv install 2.7.15
    fi
    if [ ! -d "$HOME/.anyenv/envs/pyenv/versions/3.7.0" ]; then
      pyenv install 3.7.0
      pyenv global 3.7.0
    fi
    info "Installed python 2.7 & 3.7"
    source $HOME/.bashrc
  else
    warn "pyenv not found. installing..."
    install_langenv
    install_python
  fi
}