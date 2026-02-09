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
# Debian language runtimes (python / go / anyenv)
###############################################################################

echo ""
info "30 Install language runtimes (python / go / anyenv)"
echo ""

if [ "$EUID" -eq 0 ]; then
  warn "Running as root is not recommended. sudo will be used instead."
fi

if ! has sudo; then
  error "sudo is required on Debian"
  return 0
fi

info "Installing build dependencies..."

sudo apt-get update -qq
sudo apt-get install -y -qq \
  build-essential \
  curl \
  git \
  ca-certificates \
  libssl-dev \
  zlib1g-dev \
  libbz2-dev \
  libreadline-dev \
  libsqlite3-dev \
  libffi-dev \
  liblzma-dev \
  tk-dev \
  xz-utils


###############################################################################
# anyenv
###############################################################################

install_anyenv() {
  ANYENV_ROOT="$HOME/.anyenv"
  LOCALRC="${LOCALRC:-$HOME/.bashrc.local}"

  # ---------------------------------------------------------------------------
  # anyenv
  # ---------------------------------------------------------------------------
  info "Setup anyenv"
  if [ -d "$ANYENV_ROOT" ]; then
    info "anyenv already installed"
  else
    git clone https://github.com/anyenv/anyenv.git "$ANYENV_ROOT"
  fi

  export PATH="$ANYENV_ROOT/bin:$PATH"

  if ! command -v anyenv >/dev/null 2>&1; then
    die "anyenv not found in PATH"
  fi

  # ---------------------------------------------------------------------------
  # plugins
  # ---------------------------------------------------------------------------
  info "Setup anyenv plugins"

  mkdir -p "$ANYENV_ROOT/plugins"

  install_plugin() {
    local repo="$1"
    local name="$2"
    local dst="$ANYENV_ROOT/plugins/$name"

    if [ -d "$dst" ]; then
      info "plugin already exists: $name"
    else
      git clone "$repo" "$dst"
    fi
  }

  install_plugin https://github.com/znz/anyenv-update.git anyenv-update
  install_plugin https://github.com/znz/anyenv-git.git    anyenv-git

  # ---------------------------------------------------------------------------
  # shell init (idempotent)
  # ---------------------------------------------------------------------------
  if [ ! -f "$LOCALRC" ]; then
    touch "$LOCALRC"
  fi

  if grep -q '### anyenv' "$LOCALRC"; then
    info "anyenv init already configured"
  else
    warn "Adding anyenv init to $LOCALRC"

    cat >> "$LOCALRC" <<'EOF'

### anyenv
if [ -d "$HOME/.anyenv" ]; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
  # tmux
  for D in $(ls "$HOME"/.anyenv/envs); do
    export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
  done
fi

EOF
  fi

  # ---------------------------------------------------------------------------
  # anyenv init
  # ---------------------------------------------------------------------------
  info "Initializing anyenv"
  anyenv init -q || true

  if [ ! -d "$ANYENV_ROOT/envs" ]; then
    anyenv install --init
  fi

  # ---------------------------------------------------------------------------
  # install envs
  # ---------------------------------------------------------------------------
  info "Installing language envs"

  install_env() {
    local env="$1"
    if anyenv envs | grep -qx "$env"; then
      info "$env already installed"
    else
      anyenv install "$env"
    fi
  }

  for env in pyenv goenv; do
    install_env "$env"
  done
}

install_anyenv

###############################################################################
# pyenv (Python)
###############################################################################

export PATH="$HOME/.pyenv/bin:$PATH"

if command -v pyenv >/dev/null 2>&1; then
  PYTHON_VERSION_DEFAULT="3.12.2"

  if ! pyenv versions --bare | grep -q "^${PYTHON_VERSION_DEFAULT}$"; then
    info "Installing Python ${PYTHON_VERSION_DEFAULT}"
    pyenv install "$PYTHON_VERSION_DEFAULT"
  fi

  pyenv global "$PYTHON_VERSION_DEFAULT"
else
  warn "pyenv not available"
fi

###############################################################################
# goenv (Go)
###############################################################################

export PATH="$HOME/.goenv/bin:$PATH"

if command -v goenv >/dev/null 2>&1; then
  GO_VERSION_DEFAULT="1.22.1"

  if ! goenv versions --bare | grep -q "^${GO_VERSION_DEFAULT}$"; then
    info "Installing Go ${GO_VERSION_DEFAULT}"
    goenv install "$GO_VERSION_DEFAULT"
  fi

  goenv global "$GO_VERSION_DEFAULT"
else
  warn "goenv not available"
fi

###############################################################################
# rust (rustup)
###############################################################################

if command -v rustup >/dev/null 2>&1; then
  info "Rust already installed"
else
  info "Installing Rust (rustup)..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs \
    | sh -s -- -y
fi

###############################################################################
# summary
###############################################################################

info "Language runtimes installed"
# shellcheck disable=SC1091
source "$HOME/.bashrc"
