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
# Base packages (Arch Linux)
###############################################################################

if ! has sudo; then
  error "Required: sudo"
  exit 1
fi

PACMAN_BASE_PACKAGES=(
  base-devel
  git
  curl
  wget
  ca-certificates
)

info "Install base packages via pacman"
sudo pacman -Syu --noconfirm
sudo pacman -S --needed --noconfirm "${PACMAN_BASE_PACKAGES[@]}"
info "Installed base packages via pacman"