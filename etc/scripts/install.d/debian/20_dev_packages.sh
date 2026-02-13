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
# Development packages (Debian)
###############################################################################

if [ "$EUID" -eq 0 ]; then
  warn "Running as root is not recommended. sudo will be used instead."
fi

if ! has sudo; then
  error "Required: sudo"
  exit 1
fi

DEV_PACKAGES=(
  coreutils
  moreutils
  tree
  unzip
  p7zip-full
  7zip
  vim
  xclip
  xsel
  poppler-utils
  ffmpeg
  resvg
  imagemagick
  mpv
  openssh-client
  openssh-server
)

info "Install development packages via apt"
sudo apt-get install -y -q "${DEV_PACKAGES[@]}"
info "Installed development packages via apt"

###############################################################################
# GitHub CLI
###############################################################################

# install_gh() {
#   if ! has gh; then
#     warn "Not available gh, installing via official repo"

#     if [[ ! -d "/etc/apt/keyrings" ]]; then
#       warn "/etc/apt/keyrings not found, generating"
#       sudo mkdir -p -m 755 /etc/apt/keyrings
#     fi

#     tmp_key="$(mktemp)"
#     trap 'rm "$tmp_key"' RETURN

#     wget -nv -O "$tmp_key" https://cli.github.com/packages/githubcli-archive-keyring.gpg
#     sudo mv "$tmp_key" /etc/apt/keyrings/githubcli-archive-keyring.gpg
#     sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg

#     if [[ ! -d "/etc/apt/sources.list.d" ]]; then
#       warn "/etc/apt/sources.list.d not found, generating"
#       sudo mkdir -p -m 755 /etc/apt/sources.list.d
#     fi

#     echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
#       | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null

#     sudo apt-get update -y -q
#     sudo apt-get install -y -q gh

#     info "Installed gh"
#   fi
# }

# install_gh
