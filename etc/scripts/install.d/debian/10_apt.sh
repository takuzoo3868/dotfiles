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
# Debian base APT setup
###############################################################################

echo ""
info "10 APT base setup (Debian)"
echo ""

if [ "$EUID" -eq 0 ]; then
  warn "Running as root is not recommended. sudo will be used instead."
fi

if ! has sudo; then
  error "sudo is required on Debian"
  return 0
fi

sudo apt-get update -y -q

APT_BASE_PACKAGES=(
  build-essential
  apt-transport-https
  ca-certificates
  software-properties-common
  gnupg
  gnupg2
  lsb-release
  locales
)

info "Installing base APT packages"
sudo apt-get install -y -q "${APT_BASE_PACKAGES[@]}"

###############################################################################
# Locale setup (Debian-safe)
###############################################################################

if ! locale -a | grep -q '^en_US\.utf8$'; then
  info "Generating locale: en_US.UTF-8"
  sudo locale-gen en_US.UTF-8
fi