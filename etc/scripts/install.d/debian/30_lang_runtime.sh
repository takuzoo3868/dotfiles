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
# Development packages (mise-en-place)
###############################################################################

if [ "$EUID" -eq 0 ]; then
  warn "Running as root is not recommended. sudo will be used instead."
fi

if ! has sudo; then
  error "Required: sudo"
  exit 1
fi

###############################################################################
# mise-en-place
###############################################################################

info "mise-en-place"
if ! has mise; then
  warn "Not available mise, installing via curl..."
  curl https://mise.run | sh
  eval "$("$HOME"/.local/bin/mise activate bash --shims)"

  if [ ! -f "$LOCALRC" ]; then
    ensure_dir "$HOME/.bash"
    touch "$LOCALRC"
  fi

  if grep -q '### mise' "$LOCALRC"; then
    info "Already configured mise in $LOCALRC"
  else
    warn "Add mise init to $LOCALRC"

    cat >> "$LOCALRC" <<'EOF'

### mise
if [ -x "$HOME/.local/bin/mise" ]; then
  eval "$("$HOME/.local/bin/mise" activate bash)"
fi
export MISE_DATA_DIR="$HOME/.local/share/mise"
export MISE_STATE_DIR="$HOME/.local/state/mise"
export MISE_CONFIG_DIR="$HOME/.config/mise"
EOF
  info "Installed mise!!!"
  fi
else
  warn "Already installed mise!"
fi

info "Install development packages via mise"
if [[ -n "${CI:-}" ]]; then
  warn "CI detected, Constrain jobs..."
  mise install -y -j 1
else
  mise install -y -j 4
fi
# shellcheck disable=SC1091
source "$HOME/.bashrc"
info "Installed development packages via mise"
