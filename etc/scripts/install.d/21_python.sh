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
info "21 Install Python"
echo ""

# install python
install_python(){
  if is_exists "pyenv"; then
    if [ ! -d "$HOME/.anyenv/envs/pyenv/versions/2.7.15" ]; then
      pyenv install 2.7.15
    fi
    if [ ! -d "$HOME/.anyenv/envs/pyenv/versions/3.7.0" ]; then
      pyenv install 3.7.0
      pyenv global 3.7.0
    fi
    info "Installed python 2.7 & 3.7"
    source "$HOME"/.bashrc
  else
    warn "pyenv not found. installing..."
    install_langenv
    install_python
  fi
}

if is_exists "pyenv"; then
  install_python
else
  install_langenv
  install_python
fi

if is_exists "pipenv"; then
  info "Installed pyenv & pipenv."
else
  brew install pipenv
fi

# echo ""
# info "Check PIPENV_VENV_IN_PROJECT..."
# if $(cat "$HOME"/.bashrc_local | grep PIPENV_VENV_IN_PROJECT > /dev/null) ; then
#   info "export is OK"
# else
#   warn "export is NG --> bashrc_local"
# fi
