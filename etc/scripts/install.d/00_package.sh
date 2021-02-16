#!/usr/bin/env bash

# Author: takuzoo3868
# Last Modified: 17 Feb 2021.

trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -euo pipefail

# set dotfiles path
dotfiles=$HOME/.dotfiles

# load lib script (functions)
# shellcheck source="$dotfiles"/etc/lib/header.sh
# shellcheck disable=SC1091
. "$dotfiles"/etc/lib/header.sh

echo ""
info "00 Install packages"
echo ""

PKG_DEFAULT="coreutils bash vim git python tmux curl fish"

ubuntu() {
  PKG_UBUNTU="peco openssh-server libssl-dev locales-all"

  sudo apt update -q -y
  sudo apt upgrade -y
  sudo apt install -q -y "$PKG_DEFAULT"
  sudo apt install -q -y "$PKG_UBUNTU"

  if ! has nvim; then
    info "neovim has not installed yet."
    sudo apt install software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/stable
    sudo apt update -q
    sudo apt-get install neovim
    sudo apt install python-dev python-pip python3-dev python3-pip xclip xsel
  fi
}

archlinux() {
  PKG_ARCH="ghq peco hub sakura fzf p7zip neovim python2-neovim python-pynvim llvm baobab radare2 weechat ranger"

  if ! has yay; then
    warn "yay has not installed yet."
    git clone https://aur.archlinux.org/yay.git
    cd yay && makepkg -si
  fi
  
  yay -Syu --noconfirm
  yay -S --needed "$PKG_DEFAULT"
  yay -S --needed "$PKG_ARCH"
}

darwin() {
  PKG_OSX="task trash exiftool peco screenfetch neovim wget bat binutils p7zip tree llvm ranger"

  info "xcode-select --install"
  touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress;
  PROD=$(softwareupdate -l |
    grep "\*.*Command Line" |
    head -n 1 | awk -F"*" '{print $2}' |
    sed -e 's/^ *//' |
    tr -d '\n')
  softwareupdate -i "$PROD" -v;

  # install brew
  if ! hash brew 2> /dev/null; then
    warn "Homebrew has not instaled yet"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    brew upgrade
    brew tap caskroom/cask
  fi

  brew install "$PKG_DEFAULT"
  brew install "$PKG_OSX"
}

android() {
  PKG_ANDROID="ncurses-utils binutils coreutils file grep wget taskwarrior neovim"

  pkg update
  pkg install "$PKG_DEFAULT"
  pkg install "$PKG_ANDROID"
  termux-setup-storage
}

case $(detect_os) in
  ubuntu)
    ubuntu ;;
  archlinux)
    archlinux ;;
  darwin)
    darwin ;;
  android)
    android ;;
esac