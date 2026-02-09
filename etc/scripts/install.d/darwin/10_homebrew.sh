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
# Homebrew setup
###############################################################################

echo ""
info "10 Homebrew setup"
echo ""

if ! xcode-select -p >/dev/null 2>&1; then
  info "Installing Xcode Command Line Tools..."
  xcode-select --install

  # wait until installation finished
  until xcode-select -p >/dev/null 2>&1; do
    sleep 10
  done
else
  info "Xcode Command Line Tools already installed"
fi

if ! command -v brew >/dev/null 2>&1; then
  warn "Homebrew not found, installing via curl"

  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  info "Homebrew already installed"
fi

brew update
brew upgrade