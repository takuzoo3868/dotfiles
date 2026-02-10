#!/usr/bin/env bash
#
# header.sh - Common helper functions for dotfiles
#
# Author: takuzoo3868
# Last Modified: 9 Feb 2026.
#

set -Eeuo pipefail
trap 'echo "[ERROR] ${BASH_SOURCE[0]}:${LINENO} aborted." >&2' ERR INT

###############################################################################
# Load mise (non-interactive / CI safe)
###############################################################################

if [ -x "$HOME/.local/bin/mise" ]; then
  export PATH="$HOME/.local/bin:$PATH"
  eval "$("$HOME/.local/bin/mise" activate bash --shims || true)"
fi

###############################################################################
# Terminal colors (safe)
###############################################################################

if command -v tput >/dev/null 2>&1 && [[ -t 1 ]] && [[ "$(tput colors 2>/dev/null || echo 0)" -ge 8 ]]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BOLD="$(tput bold)"
  RESET="$(tput sgr0)"
else
  RED=""; GREEN=""; YELLOW=""; BOLD=""; RESET=""
fi

export RED GREEN YELLOW BOLD RESET

###############################################################################
# Logging helpers
###############################################################################

info()  { printf "%s[+] %s%s\n" "$GREEN" "$*" "$RESET"; }
warn()  { printf "%s[*] %s%s\n" "$YELLOW" "$*" "$RESET"; }
error() { printf "%s[-] %s%s\n" "$RED" "$*" "$RESET" >&2; }
die()   { error "$*"; exit 1; }

###############################################################################
# Command helpers
###############################################################################

has() {
  command -v "$1" >/dev/null 2>&1
}

is_exists() {
  which "$1" >/dev/null 2>&1
  return $?
}

is_bash() {
  [[ -n "${BASH_VERSION:-}" ]]
}

###############################################################################
# sed in-place helper (GNU / BSD)
###############################################################################

if sed --version 2>/dev/null | grep -q GNU; then
  sedi() { sed -i "$@"; }
else
  sedi() { sed -i "" "$@"; }
fi

###############################################################################
# Filesystem helpers
###############################################################################

ensure_dir() {
  mkdir -p "$1"
}

symlink() {
  local src="$1"
  local dst="$2"

  if [[ ! -e "$src" ]]; then
    warn "source not found: $src"
    return 0
  fi

  if [[ -L "$dst" ]] && [[ "$(readlink "$dst")" == "$src" ]]; then
    printf '%s -> %s\n' "$dst" "$src" >>"$MANIFEST"
    echo "==> already linked: $dst"
    return 0
  fi

  ln -sfn "$src" "$dst"
  printf '%s -> %s\n' "$dst" "$src" >>"$MANIFEST"
  echo "==> linked: $dst -> $src"
}

###############################################################################
# OS detection
###############################################################################

detect_os() {
  case "$(uname -s)" in
    Linux*)
      if grep -qi microsoft /proc/version 2>/dev/null; then
        echo wsl
      else
        linux_distribution
      fi
      ;;
    Darwin)
      echo darwin
      ;;
    CYGWIN*|MSYS*|MINGW*)
      echo windows
      ;;
    *)
      echo unknown
      ;;
  esac
}

linux_distribution() {
  if [[ -f /etc/debian_version ]]; then
    if grep -qi ubuntu /etc/os-release 2>/dev/null; then
      echo ubuntu
    else
      echo debian
    fi
  elif [[ -f /etc/arch-release ]]; then
    echo archlinux
  # elif [[ -d /system/app && -d /system/priv-app ]]; then
  #   echo android
  else
    echo unknown_linux
  fi
}