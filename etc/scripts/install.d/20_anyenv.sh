#!/usr/bin/env bash

# Author: takuzoo3868
# Last Modified: 17 Feb 2021.

trap 'echo Error: $0:$LINENO stopped; exit 1' ERR INT
set -euo pipefail

# set dotfiles path
dotfiles=$HOME/.dotfiles
localrc=$HOME/.bash/local.bash

# load lib script (functions)
# shellcheck source="$dotfiles"/etc/lib/header.sh
# shellcheck disable=SC1091
. "$dotfiles"/etc/lib/header.sh

install_anyenv() {
  echo ""
  info "20 Install any environment managers"
  echo ""

  if is_exists "anyenv"; then
    info "anyenv is already installed"
  else
    warn "anyenv has not installed yet"
    git clone https://github.com/anyenv/anyenv.git $HOME/.anyenv
    source $HOME/.bashrc

    # plugins
    mkdir -p $HOME/.anyenv/plugins
    git clone https://github.com/znz/anyenv-update.git $HOME/.anyenv/plugins/anyenv-update
    git clone https://github.com/znz/anyenv-git.git $HOME/.anyenv/plugins/anyenv-git
  fi

  # check exist local bashrc
  if [ ! -f $localrc ]; then
    touch $localrc
  fi

  if grep -q "### anyenv" "$localrc"; then
    info "anyenv: export PATH is ok"
  else
    warn "anyenv: not export PATH..."
    tee -a $localrc <<EOF

### anyenv
if [ -d $HOME/.anyenv ] ; then
    export PATH="$HOME/.anyenv/bin:$PATH"
    eval "$(anyenv init -)"
    # tmux
    for D in `\ls $HOME/.anyenv/envs`
    do
        export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
    done
fi

EOF
    source $HOME/.bashrc
  fi
  
  $HOME/.anyenv/bin/anyenv init
  # exec $SHELL -l
  source $HOME/.bashrc
  anyenv install --init

  for lang_env in goenv pyenv jenv rbenv; do
    anyenv install $lang_env
  done
  info "Installed {go,py,j,rb}env"
}

install_anyenv
