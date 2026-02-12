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
# Development packages (macOS)
###############################################################################

DEV_PACKAGES=(
  coreutils
  moreutils
  curl
  wget
  git
  tree
  gnu-sed
  sevenzip
  vim
  reattach-to-user-namespace
  poppler
  ffmpeg
  resvg
  imagemagick
  mpv
  openssl
)

info "Install base packages via homebrew"
brew install --quiet "${DEV_PACKAGES[@]}"
info "Installed base packages via homebrew"
