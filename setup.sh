#!/bin/sh

set -e
set -u

setup() {
  dotfiles=$HOME/.dotfiles

  # パッケージの存在確認
  has() {
    type "$1" > /dev/null 2>&1
  }

  symlink() {
    [ -e "$2" ] || ln -s "$1" "$2"
  }


  install_package() {
    if [ -e /etc/arch-release ]; then
      yaourt -S $* 
    elif [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
      sudo apt install $*
    fi
  }
  
  add_repository() {
    sudo add-apt-repository $*
  }
  
  update_repository() {
    sudo apt update
  }

  # dotfilesのセットアップ
  echo "Hello, World!"
  if [ -d "$dotfiles" ]; then
    (cd "$dotfiles" && git pull --rebase)
  else
    git clone https://github.com/takuzoo3868/dotfiles "$dotfiles"
  fi

  # Gitのセットアップ
  if ! has git; then
    install_package git
  fi
  symlink "$dotfiles/.gitconfig" "$HOME/.gitconfig"


  # Vimのセットアップ
  if ! has vim; then
    install_package vim
  fi
  symlink "$dotfiles/.vimrc" "$HOME/.vimrc"

  # Neovimのセットアップ
  if ! has nvim; then
    if  [ -e /etc/arch-release ]; then
      install_package python2-neovim python-neovim
      install_package neovim
    elif [ -e /etc/debian_version ] || [ -e /etc/debian_release ]; then
      add_repository ppa:neovim-ppa/unstable
      update_repository
      install_package python-dev python-pip python3-dev python3-pip
      install_package neovim
    fi
  fi
  symlink "$dotfiles/.config/nvim" "$HOME/.config/nvim"

  # Powerlineのセットアップ
  if ! has powerline; then
    install_package powerline
  fi

}

setup
