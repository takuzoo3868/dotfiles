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
  exit 1
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
  symlink "$(command -v fdfind)" "$LOCAL_BIN/fd"
fi

###############################################################################
# btop themes
###############################################################################

info "btop theme"
if ! has btop; then
  warn "Not available btop, skipping"
else
  CONFIG_HOME="${XDG_CONFIG_HOME:-$HOME/.config}"
  DEST_DIR="${CONFIG_HOME}/btop/themes"

  ensure_dir "$DEST_DIR"

  install_btop_theme() {
    local base_url="$1"
    shift
    local themes=("$@")

    for theme in "${themes[@]}"; do
      local file_path="${DEST_DIR}/${theme}"
      local download_url="${base_url}${theme}"

      if [[ -e "$file_path" ]]; then
        warn "Already installed: ${theme}"
      else
        echo "==> Install theme: ${theme}"

        if has curl; then
          curl -fsSL "$download_url" -o "$file_path"
        else
          wget -q "$download_url" -O "$file_path"
        fi
      fi
    done
  }

  info "Install btop theme via github"

  install_btop_theme \
    "https://raw.githubusercontent.com/catppuccin/btop/main/themes/" \
    catppuccin_frappe.theme \
    catppuccin_latte.theme \
    catppuccin_macchiato.theme \
    catppuccin_mocha.theme
  
  install_btop_theme \
    "https://raw.githubusercontent.com/aristocratos/btop/main/themes/" \
    matcha-dark-sea.theme
  
  info "Installed btop theme via github"
fi
