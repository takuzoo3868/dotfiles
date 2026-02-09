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
# Ubuntu base APT setup
###############################################################################

echo ""
info "10 APT base setup (Ubuntu)"
echo ""

if ! has sudo; then
  error "sudo is required on Ubuntu"
  return 0
fi

sudo apt-get update -y -qq
sudo apt-get upgrade -y -qq

APT_BASE_PACKAGES=(
  build-essential
  apt-transport-https
  ca-certificates
  software-properties-common
  locales-all
  openssh-server
  libssl-dev
)

info "Installing base APT packages"
sudo apt-get install -y -qq "${APT_BASE_PACKAGES[@]}"
