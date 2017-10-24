#!/bin/bash

# Author: takuzoo3868
# Last Modified: 23 Oct 2017.

# If you use termux on Android, try this.
#/data/data/com.termux/files/usr/bin/sh

set -eu

# set dotfiles path
dotfiles=$HOME/.dotfiles

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
  echo -n "  info  "
  printf "${NORMAL}"
  echo "$1"
}

# error: output terminal red
error() {
  printf "${RED}"
  echo -n "  error "
  printf "${NORMAL}"
  echo "$1"
}

# warn: output terminal yellow
warn() {
  printf "${YELLOW}"
  echo -n "  warn  "
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

# check package
has() {
  type "$1" > /dev/null 2>&1
}

# create symlink
symlink() {
  [ -e "$2" ] || ln -sf "$1" "$2"
}

# install package if it dose not exist
install_package() {
  if [ -e /etc/arch-release ]; then
    yaourt -S $* 
  elif [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
    sudo apt install $*
  fi
}
  
# add non-suported repository
add_repository() {
  if [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
    sudo add-apt-repository $*
  fi
}
  
# check update
update_repository() {
  if [ -e /etc/arch-release ]; then
    yaourt -Syua 
  elif [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
    sudo apt update
  fi
}
  
# install python module
install_python() {
  sudo pip install $*
}
  


### Start install script

dotfiles_logo='
   ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
 ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
 ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
 ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
 ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
 ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
                                                              
  *** WHAT IS INSIDE? ***
  1. Download my dotfiles from https://github.com/takuzoo3868/dotfiles
  2. Symlinking dotfiles to your home directory
  3. Install packages
  
  *** HOW TO INSTALL? ***
  See the README for documentation.
  Licensed under the MIT license.  
'

printf "${BOLD}"
echo   "$dotfiles_logo"
printf "${NORMAL}"

log "*** ATTENTION ***"
log "This script can change your entire setup."
log "I recommend to read first. You can even copy commands one by one."
echo ""
read -p "$(warn 'Are you sure you want to install it? [y/N] ')" -n 1 -r


if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo ""
  error 'Installation failed. Nothing changed.'
  exit 1
fi

echo ""
info "(U^w^) < Start install the dotfiles. Your important files will move into ~/.backup."


if [ ! -d "$dotfiles" ]; then
  info "(U^q^) < Installing dotfiles for the first time..."
  git clone git@github.com:takuzoo3868/dotfiles.git "$dotfiles"
else
  info "(U^w^) < dofiles is already installed!!!"
fi

# Bash
echo ">>> bash"
symlink "$dotfiles/.bashrc" "$HOME/.bashrc"
printf "<<< [ ${BOLD}${GREEN}ok${NORMAL} ]\n"


# Git
echo ">>> git"
if ! has git; then
  install_package git || echo "Failed to install git"
fi
symlink "$dotfiles/.gitconfig" "$HOME/.gitconfig"
symlink "$dotfiles/.gitignore_global" "$HOME/.gitignore_global"
symlink "$dotfiles/.gitmessage" "$HOME/.gitmessage"
mkdir -p $HOME/.git_template/hooks
printf "<<< [ ${BOLD}${GREEN}ok${NORMAL} ]\n"


# Vim
echo ">>> neovim & vim"
if ! has vim; then
  install_package vim || echo "Failed to install vim"
fi
symlink "$dotfiles/.vimrc" "$HOME/.vimrc"

# Neovim
if ! has nvim; then
  if  [ -e /etc/arch-release ]; then
    install_package python2-neovim python-neovim
    install_package neovim
  elif [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
    install_package software-properties-common
    add_repository ppa:neovim-ppa/unstable
    update_repository
    install_package python-dev python-pip python3-dev python3-pip
    install_package neovim
    install_package xclip xsel
  fi
fi
#sudo pip2 install --upgrade neovim
#sudo pip3 install --upgrade neovim
symlink "$dotfiles/.config/nvim" "$HOME/.config/nvim"
printf "<<< [ ${BOLD}${GREEN}ok${NORMAL} ]\n"

# Nyaovim
echo ">>> nyaovim"
symlink "$dotfiles/.config/nyaovim" "$HOME/.config/nyaovim"
printf "<<< [ ${BOLD}${GREEN}ok${NORMAL} ]\n"


# Tmux
echo ">>> tmux"
if ! has tmux; then
  install_package tmux || echo "Failed to install tmux"
fi
symlink "$dotfiles/.config/tmux/.tmux.conf" "$HOME/.tmux.conf"
printf "<<< [ ${BOLD}${GREEN}ok${NORMAL} ]\n"


# Powerline
echo ">>> powerline"
if ! has powerline; then
  install_python --user git+git://github.com/powerline/powerline
  install_python psutil
fi
symlink "$dotfiles/.config/powerline" "$HOME/.config/powerline"
printf "<<< [ ${BOLD}${GREEN}ok${NORMAL} ]\n"




