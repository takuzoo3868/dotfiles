#!/bin/bash

set -euo

# check package
has() {
  type "$1" > /dev/null 2>&1
}

if ! has powerline; then
  echo ""
  info "Hasnt installed powerline yet. Installing..."
  sudo pip install --user git+git://github.com/powerline/powerline
  sudo pip install psutil
  info "Installed powerline!!!"
fi
