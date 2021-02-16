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

brewery() {
  echo ""
  info "10 Brew bundle"
  echo ""

  if is_exists "brew"; then
    info "Homebrew is already installed"
  else
    warn "Homebrew has not installed yet"
    xcode-select --install
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    info "brew: installed successfully."
  fi

  builtin cd $dotfiles/etc/scripts/install.d
  if [ ! -f Brewfile ]; then
    error "Brewfile: not found"
  else
    brew bundle
    info "brew: tapped successfully."
  fi
  builtin cd $dotfiles
}

case $(detect_os) in
  darwin)
    brewery ;;
  *)
    info "Skip 10-brew" ;;
esac