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

: "${LOCALRC:=$HOME/.bash/local.bash}"
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

if ! has sudo; then
  error "Required: sudo"
  exit 1
fi

###############################################################################
# bashrc.local
###############################################################################

setup_bashrc_local() {
  info "local.bash"
  if [ ! -f "$LOCALRC" ]; then
    ensure_dir "$HOME/.bash"
    touch "$LOCALRC"
  fi

  if grep -q '### path' "$LOCALRC"; then
    warn "Already configured path in $LOCALRC"
  else
    echo "==> Add path to $LOCALRC"

    cat >> "$LOCALRC" <<'EOF'

### path
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
EOF
  fi

  if grep -q '### tmux' "$LOCALRC"; then
    warn "Already configured tmux in $LOCALRC"
  else
    echo "==> Add tmux to $LOCALRC"
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
    warn "Already configured uv in $LOCALRC"
  else
    echo "==> Add uv to $LOCALRC"

    cat >> "$LOCALRC" <<'EOF'

### python uv
export UV_LINK_MODE=copy
export UV_COMPILE_BYTECODE=1
export UV_CACHE_DIR="$HOME/.cache/uv"
EOF
  fi

  if grep -q '### python ruff' "$LOCALRC"; then
    warn "Already configured ruff in $LOCALRC"
  else
    echo "==> Add ruff to $LOCALRC"

    cat >> "$LOCALRC" <<'EOF'

### python ruff
export RUFF_CACHE_DIR="$HOME/.cache/ruff"
EOF
  fi
}

###############################################################################
# Main
###############################################################################

info "Setup local.bash settings"
setup_bashrc_local
info "Finished local.bash settings!"
