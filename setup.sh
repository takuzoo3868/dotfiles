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
    elif [ -e /etc/lsb-release ]; then
      apt install $*
    fi
  }

  # dotfilesのセットアップ
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

  symlink "$dotfiles/.config/nvim" "$HOME/.config/nvim"

}

setup
