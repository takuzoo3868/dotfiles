#!/usr/bin/env bash

# Author: takuzoo3868
# Last Modified: 08 Jun 2018.

trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -euo pipefail

# set dotfiles path
dotfiles=$HOME/.dotfiles

# load lib script (functions)
. $dotfiles/etc/lib/header.sh


if is_exists "lolcat"; then
  info "Installed lolcat"
else
  info "Install lolcat"
  brew install lolcat
fi

if is_exists "octocatsay"; then
  info "Installed octocatsay"
else
  info "Install octocatsay"
  if [ ! -d "$HOME/.local/bin" ]; then
    mkdir -p $HOME/.local/bin
    cd $HOME/.local/bin
  else
    cd $HOME/.local/bin
  fi
  wget https://raw.githubusercontent.com/cobyism/octocatsay/master/bin/octocatsay
  wget https://raw.githubusercontent.com/cobyism/octocatsay/master/bin/octocatthink
  cd $HOME
fi

info "Dwarf Fortress is a single-player fantasy game."
#brew cask install dwarf-fortress

info "Installation was successful. Terminal restart..."
exec $SHELL -l