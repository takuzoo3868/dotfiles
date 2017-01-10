#!/bin/sh

set -e
set -u

setup() {
  dotfiles=$HOME/.dotfiles

  ln -s ~/.dotfiles/.gitconfig ~/.gitconfig

  ln -s ~/.dotfiles/.vimrc ~/.vimrc
  ln -s ~/.dotfiles/.config/nvim ~/.config/nvim

}

setup
