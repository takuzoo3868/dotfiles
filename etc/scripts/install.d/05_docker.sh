#!/usr/bin/env bash

# Author: takuzoo3868
# Last Modified: 17 Feb 2021.

trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -euo pipefail

# set dotfiles path
dotfiles=$HOME/.dotfiles

# load lib script (functions)
# shellcheck source="$dotfiles"/etc/lib/header.sh
# shellcheck disable=SC1091
. "$dotfiles"/etc/lib/header.sh

echo ""
info "05 Install docker"
echo ""

case $(detect_os) in
  android)
    echo "Skip 05-docker" ;;
  *)
    /bin/bash -c "$(curl -fsSL https://get.docker.com)" ;;
esac