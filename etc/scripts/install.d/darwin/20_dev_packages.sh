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
# macOS development packages
###############################################################################

echo ""
info "20 Development packages (macOS)"
echo ""

DEV_PACKAGES=(
  coreutils
  moreutils
  bat
  bash
  curl
  wget
  httpie
  git
  nkf
  gnu-sed
  python3
  python3-pip
  tmux
  tmuxp
  reattach-to-user-namespace
  jq
  sevenzip
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
  openssl
  fontforge
)

info "Installing development packages"
brew install "${DEV_PACKAGES[@]}"