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
# Useful tools
###############################################################################

echo ""
info "40 Install useful tools"
echo ""

if ! has sudo; then
  error "sudo is required on Ubuntu"
  return 0
fi

###############################################################################
# yazi
###############################################################################

if ! has yazi; then
  info "Installing yazi"
  cargo install --force yazi-build

  install_yazi_plugin() {
    ya pack --list | grep -q "$1" || ya pack -a "$1"
  }
  install_yazi_plugin AdithyanA2005/nord
  install_yazi_plugin yazi-rs/plugins:git
  install_yazi_plugin yazi-rs/plugins:smart-enter
fi
