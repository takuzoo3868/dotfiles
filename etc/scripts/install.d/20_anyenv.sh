#!/usr/bin/env bash

# Author: takuzoo3868
# Last Modified: 17 Feb 2021.

trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -euo pipefail

# set dotfiles path as default variable
if [ -z "${DOTPATH:-}" ]; then
    DOTPATH=$HOME/.dotfiles; export DOTPATH
fi
LOCALRC=$HOME/.bash/local.bash

# load lib script (functions)
. "$DOTPATH"/etc/lib/header.sh


install_anyenv() {
  echo ""
  info "20 Install any environment managers"
  echo ""

  if is_exists "anyenv"; then
    info "anyenv is already installed"
  else
    warn "anyenv has not installed yet"
    git clone https://github.com/anyenv/anyenv.git "$HOME"/.anyenv
    source "$HOME"/.bashrc

    # plugins
    mkdir -p "$HOME"/.anyenv/plugins
    git clone https://github.com/znz/anyenv-update.git "$HOME"/.anyenv/plugins/anyenv-update
    git clone https://github.com/znz/anyenv-git.git "$HOME"/.anyenv/plugins/anyenv-git
  fi

  # check exist local bashrc
  if [ ! -f "$LOCALRC" ]; then
    touch "$LOCALRC"
  fi

  if grep -q "### anyenv" "$LOCALRC"; then
    info "anyenv: export PATH is ok"
  else
    warn "anyenv: not export PATH..."
    tee -a "$LOCALRC" <<EOF

### anyenv
if [ -d "$HOME"/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    # tmux
    for D in $(ls "$HOME"/.anyenv/envs); do
      export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
    done
fi

EOF
    # shellcheck disable=SC1091
    source "$HOME"/.bashrc
  fi
  
  "$HOME"/.anyenv/bin/anyenv init
  # exec $SHELL -l
  source "$HOME"/.bashrc
  anyenv install --init

  for l in goenv pyenv jenv rbenv; do
    anyenv install $l
  done
  info "Installed go, python, java and ruby environment"
}

install_anyenv
