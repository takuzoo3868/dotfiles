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
# Debian development packages
###############################################################################

echo ""
info "20 Development packages (Debian)"
echo ""

if [ "$EUID" -eq 0 ]; then
  warn "Running as root is not recommended. sudo will be used instead."
fi

if ! has sudo; then
  error "sudo is required on Debian"
  return 0
fi

DEV_PACKAGES=(
  coreutils
  moreutils
  bash
  git
  python3
  python3-pip
  tmux
  tmuxp
  curl
  wget
  jq
  p7zip-full
  tree
  ripgrep
  fd-find
  openssh-client
  openssh-server
  ffmpeg
  7zip
  poppler-utils
  fzf
  zoxide
  imagemagick
)

info "Installing development packages"
sudo apt-get install -y -qq "${DEV_PACKAGES[@]}"

info "Installing Vim (latest)"
VIM_APPIMAGE="$VIM_BIN_DIR/vim"
VIM_URL=$(
  curl -fsSL https://api.github.com/repos/vim/vim-appimage/releases/latest \
  | grep browser_download_url \
  | grep AppImage \
  | cut -d '"' -f 4 \
  | head -n 1
)

if [[ -z "$VIM_URL" ]]; then
  warn "Failed to resolve Vim download URL"
else
  curl -fLo "$VIM_APPIMAGE" "$VIM_URL"
  chmod +x "$VIM_APPIMAGE"
fi

if ! has nvim; then
  warn "neovim not found, installing via appimage"

  NVIM_APPIMAGE="$LOCAL_BIN/nvim"
  NVIM_URL=$(
    curl -fsSL https://api.github.com/repos/neovim/neovim/releases/latest \
    | grep browser_download_url \
    | grep appimage \
    | cut -d '"' -f 4 \
    | head -n 1
  )

  if [[ -z "$NVIM_URL" ]]; then
    warn "Failed to resolve Neovim download URL"
  else
    curl -fLo "$NVIM_APPIMAGE" "$NVIM_URL"
    chmod +x "$NVIM_APPIMAGE"
  fi
fi

###############################################################################
# fd-find compatibility (Debian specific)
###############################################################################

if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
  ln -sf "$(command -v fdfind)" "$LOCAL_BIN/fd"
fi