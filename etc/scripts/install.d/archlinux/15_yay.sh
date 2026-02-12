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
# Yet Another Yogurt
###############################################################################

install_yay() {
  if [[ -n "${CI:-}" ]]; then
    warn "CI detected, skipping yay installation"
    return 0
  fi

  if ! has yay; then
    warn "Not available yay, installing via git"

    tmp="$(mktemp -d)"
    trap 'rm -rf "$tmp"' RETURN

    git clone https://aur.archlinux.org/yay.git "$tmp"
    pushd "$tmp" >/dev/null
    makepkg -si --noconfirm
    popd >/dev/null

    info "Installed yay"
  fi
}

install_yay
