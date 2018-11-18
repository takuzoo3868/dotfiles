#!/usr/bin/env bash

# Author: takuzoo3868
# Last Modified: 19 Nov 2018.


set -euo pipefail
dotfiles=$HOME/.dotfiles


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


info() { 
  printf "${GREEN}"
  echo -n "  info  "
  printf "${NORMAL}"
  echo "$1"
}


symlink() {
  [ -e "$2" ] || ln -sf "$1" "$2"
}


## create symbolic link
echo ""
info "Creating symbolic link..."
echo ""

# Bash
info "bashrc"
symlink "$dotfiles/.bashrc" "$HOME/.bashrc"
symlink "$dotfiles/.bashrc_prompt" "$HOME/.bashrc_prompt"

# fish
info "fish"
symlink "$dotfiles/.config/fish/config.fish" "$HOME/.config/fish/config.fish"
symlink "$dotfiles/.config/fish/fishfile" "$HOME/.config/fish/fishfile"
symlink "$dotfiles/.config/fish/functions/fish_greeting.fish" "$HOME/.config/fish/functions/fish_greeting.fish"

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
symlink "$dotfiles/.config/tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"