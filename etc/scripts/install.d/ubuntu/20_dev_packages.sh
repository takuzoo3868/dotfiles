#!/usr/bin/env bash
#
# Author: takuzoo3868
# Last Modified: 9 Feb 2026.
#

set -Eeuo pipefail
trap 'echo "[ERROR] ${BASH_SOURCE[0]}:${LINENO} aborted." >&2' ERR INT

###############################################################################
# Globals
###############################################################################

: "${DOTPATH:=$HOME/.dotfiles}"
export DOTPATH

###############################################################################
# Load shared helpers
###############################################################################

if [[ -f "$DOTPATH/etc/lib/header.sh" ]]; then
  # shellcheck source=/dev/null
  . "$DOTPATH/etc/lib/header.sh"
else
  error() { echo "[-] $*" >&2; }
  error "Failed to load shared helpers"
  exit 1
fi

###############################################################################
# Ubuntu development packages
###############################################################################

echo ""
info "20 Development packages (Ubuntu)"
echo ""

if ! has sudo; then
  error "sudo is required on Ubuntu"
  return 0
fi

DEV_PACKAGES=(
  coreutils
  moreutils
  bash
  git
  python3
  python3-pip
  tmux
  tmuxp
  curl
  wget
  jq
  p7zip-full
  tree
  ffmpeg
  7zip
  poppler-utils
  fd-find
  ripgrep
  fzf
  zoxide
  imagemagick
)

info "Installing development packages"
sudo apt-get install -y -qq "${DEV_PACKAGES[@]}"

if ! grep -Rs "^deb .*jonathonf/vim" /etc/apt/sources.list /etc/apt/sources.list.d; then
  warn "vim(latest) not found, installing via PPA"
  sudo add-apt-repository -y ppa:jonathonf/vim
  sudo apt-get update -y -qq
  sudo apt-get install -y -qq vim
fi

if ! has nvim; then
  warn "neovim not found, installing via snap"

  if has snap; then
    sudo snap install nvim --classic
    sudo apt-get install -y -qq python3-neovim xclip xsel
  else
    warn "snap not available, skipping neovim"
  fi
fi