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
# Cleanup
###############################################################################

# cleanup orphan packages
orphans=$(pacman -Qtdq 2>/dev/null || true)
if [[ -n "$orphans" ]]; then
  # shellcheck disable=SC2086
  sudo pacman -Rns $orphans --noconfirm
fi

# keep latest 2 versions by default
sudo paccache -r -k2

# cleanup AUR cache
yay -Sc --noconfirm

mise cache clear
