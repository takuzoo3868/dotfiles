#!/usr/bin/env bash

# Author: takuzoo3868
# Last Modified: 15 Feb 2021.

trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -euo pipefail

# set dotfiles path as default variable
if [ -z "${DOTPATH:-}" ]; then
    DOTPATH=$HOME/.dotfiles; export DOTPATH
fi

# load lib script (functions)
# shellcheck source="$dotfiles"/etc/lib/header.sh
# shellcheck disable=SC1091
. "$DOTPATH"/etc/lib/header.sh


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