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

: "${LOCALRC:=$HOME/.bash/.bashrc.local}"
export LOCALRC

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
# Setup local rc setting
###############################################################################

echo ""
info "50 Setup local rc setting"
echo ""

if ! has sudo; then
  error "Required: sudo"
  return 0
fi

###############################################################################
# bashrc.local
###############################################################################

setup_bashrc_local() {
  info ".bashrc.local"
  if [ ! -f "$LOCALRC" ]; then
    touch "$LOCALRC"
  fi

  if grep -q '### path' "$LOCALRC"; then
    info "Already configured path in $LOCALRC"
  else
    warn "Add path to $LOCALRC"

    cat >> "$LOCALRC" <<'EOF'

### path
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

EOF
  fi

  if grep -q '### tmux' "$LOCALRC"; then
    info "Already configured tmux in $LOCALRC"
  else
    warn "Add tmux to $LOCALRC"
    echo "==> NEED WEATHER_API KEY to $LOCALRC from https://openweathermap.org/"

    cat >> "$LOCALRC" <<'EOF'

### tmux
export PATH="$HOME/.tmux/bin:$PATH"

### tmux powerline: weather
export WEATHER_API="!!! Replace your API key !!!"
export WEATHER_UNIT="metric"

EOF
  fi

  if grep -q '### python uv' "$LOCALRC"; then
    info "Already configured uv in $LOCALRC"
  else
    warn "Add uv to $LOCALRC"

    cat >> "$LOCALRC" <<'EOF'

### python uv
export UV_SYSTEM_PYTHON=1
export UV_PROJECT_ENVIRONMENT="/usr/local/"
export UV_NO_DEV=1
export UV_LINK_MODE=copy
export UV_COMPILE_BYTECODE=1

EOF
  fi
}

###############################################################################
# Main
###############################################################################

info "Setup .bashrc.local settings"
setup_bashrc_local
info "Finished .bashrc.local settings!"
