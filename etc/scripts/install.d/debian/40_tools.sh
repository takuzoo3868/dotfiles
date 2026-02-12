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

readonly LOCAL_BIN="$HOME/.local/bin"

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

if [ "$EUID" -eq 0 ]; then
  warn "Running as root is not recommended. sudo will be used instead."
fi

if ! has sudo; then
  error "Required: sudo"
  return 0
fi

###############################################################################
# yazi
###############################################################################

info "yazi plugins"
if ! has yazi; then
  warn "Not available yazi, skipping"
else
  info "Install yazi plugins via ya"
  install_yazi_plugin() {
    ya pkg list | grep -q "$1" || ya pkg add "$1"
  }
  install_yazi_plugin AdithyanA2005/nord
  install_yazi_plugin yazi-rs/plugins:git
  install_yazi_plugin yazi-rs/plugins:smart-enter
  info "Installed yazi plugins via ya"
fi

###############################################################################
# fd-find compatibility (Debian specific)
###############################################################################

if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
  ln -sf "$(command -v fdfind)" "$LOCAL_BIN/fd"
fi