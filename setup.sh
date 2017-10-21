#!/bin/sh

set -e
set -u

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

# fix sed comand diff between GNU & BSD
if sed --version 2>/dev/null | grep -q GNU; then
  alias sedi='sed -i '
else
  alias sedi='sed -i "" '
fi


setup() {
  dotfiles=$HOME/.dotfiles

  # check package
  has() {
    type "$1" > /dev/null 2>&1
  }

  # create symlink
  symlink() {
    [ -e "$2" ] || ln -sf "$1" "$2"
  }

  # install package if it doesn`t exist
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
  


  ### Start install

  dotfiles_logo='
   ██████╗  ██████╗ ████████╗███████╗██╗██╗     ███████╗███████╗
 ██╔══██╗██╔═══██╗╚══██╔══╝██╔════╝██║██║     ██╔════╝██╔════╝
 ██║  ██║██║   ██║   ██║   █████╗  ██║██║     █████╗  ███████╗
 ██║  ██║██║   ██║   ██║   ██╔══╝  ██║██║     ██╔══╝  ╚════██║
 ██████╔╝╚██████╔╝   ██║   ██║     ██║███████╗███████╗███████║
 ╚═════╝  ╚═════╝    ╚═╝   ╚═╝     ╚═╝╚══════╝╚══════╝╚══════╝
                                                              
  *** WHAT IS INSIDE? ***
  1. Download https://github.com/takuzoo3868/dotfiles.git
  2. Symlinking dot files to your home directory
  
  See the README for documentation.
  https://github.com/takuzoo3868/dotfiles
  Licensed under the MIT license.

  (U^w^) < Start install the dotfiles
'

  printf "${BOLD}${GREEN}"
  echo "$dotfiles_logo"
  printf "${NORMAL}"

  if [ ! -d "$dotfiles" ]; then
    echo "Installing dotfiles for the first time"
    git clone git@github.com:takuzoo3868/dotfiles.git "$dotfiles"
  else
    echo "dofiles is already installed"
  fi

  # Bashのセットアップ
  echo ">>> bash"
  symlink "$dotfiles/.bashrc" "$HOME/.bashrc"
  printf "<<< [ ${BOLD}${GREEN}ok${NORMAL} ]\n"


  # Gitのセットアップ
  echo ">>> git"
  if ! has git; then
    install_package git || echo "Failed to install git"
  fi
  symlink "$dotfiles/.gitconfig" "$HOME/.gitconfig"
  symlink "$dotfiles/.gitignore_global" "$HOME/.gitignore_global"
  symlink "$dotfiles/.gitmessage" "$HOME/.gitmessage"
  mkdir -p $HOME/.git_template/hooks
  printf "<<< [ ${BOLD}${GREEN}ok${NORMAL} ]\n"



  # Vimのセットアップ
  echo ">>> neovim & vim"
  if ! has vim; then
    install_package vim || echo "Failed to install vim"
  fi
  symlink "$dotfiles/.vimrc" "$HOME/.vimrc"

  # Neovimのセットアップ
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

  # Nyaovimのセットアップ
  echo ">>> nyaovim"
  symlink "$dotfiles/.config/nyaovim" "$HOME/.config/nyaovim"
  printf "<<< [ ${BOLD}${GREEN}ok${NORMAL} ]\n"

  # Tmuxのセットアップ
  echo ">>> tmux"
  if ! has tmux; then
    install_package tmux || echo "Failed to install tmux"
  fi
  symlink "$dotfiles/.config/tmux/.tmux.conf" "$HOME/.tmux.conf"
  printf "<<< [ ${BOLD}${GREEN}ok${NORMAL} ]\n"

  # Powerlineのセットアップ
  echo ">>> powerline"
  if ! has powerline; then
    install_python --user git+git://github.com/powerline/powerline
    install_python psutil
  fi
  symlink "$dotfiles/.config/powerline" "$HOME/.config/powerline"
  printf "<<< [ ${BOLD}${GREEN}ok${NORMAL} ]\n"

}

setup
