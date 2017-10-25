#!/usr/bin/env bash

# Author: takuzoo3868
# Last Modified: 24 Oct 2017.

# If you use termux on Android, try this.
#/data/data/com.termux/files/usr/bin/bash

set -euo pipefail

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
read -p "$(warn '(U^w^) < Are you sure you want to install it? [y/N] ')" -n 1 -r


if [[ ! $REPLY =~ ^[Yy]$ ]]; then
  echo ""
  error 'Installation failed. Nothing changed.'
  exit 1
fi

echo ""
info "Start install the dotfiles."

if [ ! -d "$dotfiles" ]; then
  info "Installing dotfiles for the first time..."
  git clone git@github.com:takuzoo3868/dotfiles.git "$dotfiles"
else
  info "The dofiles is already installed!!!"
fi

## install packages
echo ""
info "Installing packages..."

# package list
LIST_OF_APPS="coreutils bash vim git python3 tmux taskwarrior curl"


if [ $(uname -o) = "Android" ]; then
  ADD_APP_ANDROID="ncurses-utils binutils coreutils file grep wget"

  info "apt update"
  pkg update

  info "apt install $LIST_OF_APPS & $ADD_APP_ANDROID"
  pkg install "$ADD_APP_ANDROID"
  pkg install "$LIST_OF_APPS"

  info "pkg install neovim"
  pkg install neovim

  #info "termux-setup-storage"
  #termux-setup-storage

elif [[ $(uname) = "Linux" ]]; then

  ## Arch Linux
  if [ -f /etc/arch-release ]; then
    if ! has yaourt; then
      warn "yaort has not installed yet. Please visit wiki: https://wiki.archlinux.jp/index.php/Yaourt"
      exit 1
    fi

    info "yaourt update"
    yaourt -Syua

    info "yaourt -S $LIST_OF_APPS"
    yaourt -S $LIST_OF_APPS

    if ! has nvim; then
      echo ""
      info "Hasnt installed neovim yet. installing..."
      sudo pacman -S neovim
      info "Installed neovim!!!"
    fi

    ## Ubuntu / Debian
  elif [ -f /etc/debian_version ] || [ -f /etc/debian_release ]; then
    info "sudo apt update"
    sudo apt update -q

    info "sudo apt install $LIST_OF_APPS"
    sudo apt install -q -y $LIST_OF_APPS

    if ! has nvim; then
      echo ""
      info "Hasnt installed neovim yet. installing..."
      sudo apt install software-properties-common
      sudo add-apt-repository ppa:neovim-ppa/unstable
      sudo apt update -q
      sudo apt install python-dev python-pip python3-dev python3-pip
      sudo apt install neovim
      sudo apt install xclip xsel
      info "Installed neovim!!!"
    fi

  fi

elif [[ $(uname) = "Darwin" ]]; then
  ADD_APP_MAC="task trash"

  info "xcode-select --install"
  xcode-select --install

  if ! hash brew 2> /dev/null; then
    info "Homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi

  info "brew install $LIST_OF_APPS & $ADD_APP_MAC"
  brew install $LIST_OF_APPS
  brew install $ADD_APP_MAC

else
  # F0ck wind0ws. G0 t0 he11!
  error "Your platform ($(uname -a)) is not supported."
  exit 1
fi


## other packages
if ! has powerline; then
  echo ""
  info "Hasnt installed powerline yet. Installing..."
  sudo pip install --user git+git://github.com/powerline/powerline
  sudo pip install psutil
  info "Installed powerline!!!"
fi

## create symbolic link
echo ""
info "Creating symbolic link..."
echo ""

# Bash
info "bashrc"
symlink "$dotfiles/.bashrc" "$HOME/.bashrc"

# Git
info "gitconfig"
symlink "$dotfiles/.gitconfig" "$HOME/.gitconfig"
symlink "$dotfiles/.gitignore_global" "$HOME/.gitignore_global"
symlink "$dotfiles/.gitmessage" "$HOME/.gitmessage"
mkdir -p $HOME/.git_template/hooks

# Vim
info "vimrc"
symlink "$dotfiles/.vimrc" "$HOME/.vimrc"

# Neovim
info "config about neovim"
symlink "$dotfiles/.config/nvim" "$HOME/.config/nvim"

# Nyaovim
info "config about nyaovim"
symlink "$dotfiles/.config/nyaovim" "$HOME/.config/nyaovim"

# Tmux
info "tmux.conf"
symlink "$dotfiles/.config/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Powerline
info "config about powerline"
symlink "$dotfiles/.config/powerline" "$HOME/.config/powerline"

echo ""
info "Installation completed."
