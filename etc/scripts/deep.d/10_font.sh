#!/usr/bin/env bash
#
# Author: takuzoo3868
# Last Modified: 9 Feb 2026.
#

set -Eeuo pipefail
trap 'cleanup_tmpdir; echo "[ERROR] ${BASH_SOURCE[0]}:${LINENO} aborted." >&2' ERR INT

###############################################################################
# Globals
###############################################################################

: "${DOTPATH:=$HOME/.dotfiles}"
export DOTPATH

: "${FONTS_DIR:=${fonts_dir:-$HOME/.local/share/fonts}}"
export FONTS_DIR

NERD_REPO_URL="https://github.com/ryanoasis/nerd-fonts.git"
CICA_API_URL="https://api.github.com/repos/miiton/Cica/releases/latest"

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
# Cleanup handler
###############################################################################

cleanup_tmpdir() {
  if [[ -n "${TMPDIR_WORK:-}" && -d "$TMPDIR_WORK" ]]; then
    rm -rf "$TMPDIR_WORK"
  fi
}

###############################################################################
# Preconditions
###############################################################################

if ! is_exists "fontforge"; then
  error "fontforge is required"
  exit 1
fi

if ! is_exists "git"; then
  error "git is required"
  exit 1
fi

if ! is_exists unzip; then
  error "unzip required"
  exit 1
fi

echo ""
info "10 Build fonts (Cica patched by nerd-fonts)"
echo ""

###############################################################################
# Working directory
###############################################################################

TMPDIR_WORK="$(mktemp -d "${DOTPATH}/tmp.XXXXXX")"
cd "$TMPDIR_WORK"

###############################################################################
# Clone Nerd Fonts (shallow, idempotent)
###############################################################################

if [[ ! -d nerd-fonts ]]; then
  git clone --depth 1 "$NERD_REPO_URL" nerd-fonts
fi

cd nerd-fonts
mkdir -p orig dist

###############################################################################
# Fetch latest Cica font release
###############################################################################

cica_url="$(
  curl -fsSL "$CICA_API_URL" \
    | grep -E 'browser_download_url.*Cica_v[0-9]+\.[0-9]+\.[0-9]+\.zip' \
    | head -n 1 \
    | cut -d '"' -f 4
)"

if [[ -z "$cica_url" ]]; then
  error "Failed to resolve Cica font download URL"
  exit 1
fi

cica_zip="$TMPDIR_WORK/Cica.zip"

curl -fsSL "$cica_url" -o "$cica_zip"
unzip -oq "$cica_zip" -d orig

###############################################################################
# Patch fonts with Nerd Fonts
###############################################################################

find orig -type f -name '*.ttf' -print0 |
while IFS= read -r -d '' font; do
  fontforge -script font-patcher -c "$font" --out dist
done

###############################################################################
# Normalize filenames (space → underscore)
###############################################################################

find dist -type f -name '*.ttf' -print0 |
while IFS= read -r -d '' src; do
  dst="${src// /_}"
  if [[ "$src" != "$dst" ]]; then
    mv "$src" "$dst"
  fi
done

###############################################################################
# Install fonts (idempotent)
###############################################################################

mkdir -p "$FONTS_DIR"

if compgen -G "dist/*.ttf" > /dev/null; then
  cp -u dist/*.ttf "$FONTS_DIR"
else
  warn "No patched font files found"
fi

###############################################################################
# Cleanup
###############################################################################

info "Font installation completed successfully!"
cleanup_tmpdir