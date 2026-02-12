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
# Base packages (Ubuntu)
###############################################################################

if ! has sudo; then
  error "Required: sudo"
  return 0
fi

sudo apt-get update -y -q
sudo apt-get upgrade -y -q

APT_BASE_PACKAGES=(
  build-essential
  libreadline-dev
  apt-transport-https
  ca-certificates
  software-properties-common
  locales-all
  openssh-server
  libssl-dev
)

info "Install base packages via apt"
sudo apt-get install -y -q "${APT_BASE_PACKAGES[@]}"
info "Installed base packages via apt"
