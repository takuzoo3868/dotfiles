#!/usr/bin/env bash

# Author: takuzoo3868
# Last Modified: 17 Feb 2021.

trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -euo pipefail

# set dotfiles path as default variable
if [ -z "${DOTPATH:-}" ]; then
    DOTPATH=$HOME/.dotfiles; export DOTPATH
fi

# load lib script (functions)
. "$DOTPATH"/etc/lib/header.sh


echo ""
info "05 Install Docker"
echo ""

case $(detect_os) in
  android)
    echo "Skip 05-docker" ;;
  *)
    /bin/bash -c "$(curl -fsSL https://get.docker.com)" ;;
esac