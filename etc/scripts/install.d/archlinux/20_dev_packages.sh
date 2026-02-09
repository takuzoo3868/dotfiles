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
# Arch Linux development packages
###############################################################################

echo ""
info "20 Development packages (Arch Linux)"
echo ""

DEV_PACKAGES=(
  coreutils
  moreutils
  bat
  bash
  python3
  python3-pip
  tmux
  tmuxp
  jq
  7zip
  tree
  vim
  neovim
  yazi
  fzf
  poppler
  ffmpeg
  fd
  ripgrep
  zoxide
  resvg
  imagemagick
)

info "Installing development packages"
yay -S --needed "${DEV_PACKAGES[@]}"

###############################################################################
# yazi
###############################################################################

info "Installing yazi plugins"

install_yazi_plugin() {
  ya pack --list | grep -q "$1" || ya pack -a "$1"
}
install_yazi_plugin AdithyanA2005/nord
install_yazi_plugin yazi-rs/plugins:git
install_yazi_plugin yazi-rs/plugins:smart-enter
