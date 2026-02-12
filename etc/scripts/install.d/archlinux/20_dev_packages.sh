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
# Development packages (Arch Linux)
###############################################################################

if ! has sudo; then
  error "Required: sudo"
  return 0
fi

DEV_PACKAGES=(
  coreutils
  moreutils
  tree
  unzip
  7zip
  vim
  xclip
  xsel
  poppler
  ffmpeg
  resvg
  imagemagick
  fontforge
  mpv
  openssh
)

info "Install development packages via pacman"
sudo pacman -S --needed --noconfirm "${DEV_PACKAGES[@]}"
info "Installed development packages via pacman"
