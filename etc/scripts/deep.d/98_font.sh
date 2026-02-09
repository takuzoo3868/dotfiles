#!/usr/bin/env bash

# Author: takuzoo3868
# Last Modified: 15 Feb 2021.

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



if is_exists "fontforge"; then
  info "98 Install fonts..."
else
  error "fontforge required"
  exit 1
fi

mkdir -p $DOTPATH/tmp && cd $DOTPATH/tmp

# Download Nerd fonts
nerd_url="https://github.com/ryanoasis/nerd-fonts.git"
git clone --depth 1 "$nerd_url" && cd nerd-fonts && mkdir -p orig dist

# Download Cica fonts
cica_url=$(curl -s https://api.github.com/repos/miiton/Cica/releases/latest | grep "browser_download_url.*zip" | grep "with_emoji" | cut -d '"' -f 4)
curl -L "$cica_url" | tar -xvz -C orig

# Cica fonts repatched mapping
for font in $(find orig/ -type f -name "*.ttf"); do
  fontforge -script font-patcher -c $font --out dist
done

# Rename whitespace to underscore
find dist -type f -name "*.ttf" | while read org_name; do
  new_name=$(echo $org_name | sed 's/ /_/g')
  mv "$org_name" "$new_name"
done

# Copy to font directory
cp -u dist/* $fonts_dir

cd $DOTPATH
rm -rf tmp