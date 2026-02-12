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
# Development packages (Ubuntu)
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
  p7zip-full
  7zip
  xclip
  xsel
  poppler-utils  
  ffmpeg
  resvg
  imagemagick
  fontforge
  mpv
  openssh-client
  openssh-server
  libssl-dev
)

info "Install development packages via apt"
sudo apt-get install -y -q "${DEV_PACKAGES[@]}"
info "Installed development packages via apt"

if ! grep -qRs "^deb .*jonathonf/vim" /etc/apt/sources.list /etc/apt/sources.list.d; then
  warn "Not available vim(latest), installing via PPA"
  sudo add-apt-repository -y ppa:jonathonf/vim
  sudo apt-get update -y -q
  sudo apt-get install -y -q vim
  info "Installed vim(latest)"
fi 
