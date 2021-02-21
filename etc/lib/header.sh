#!/usr/bin/env bash

# Author: takuzoo3868
# Last Modified: 08 Jun 2021.

# use colors on terminal
tput=$(which tput)
if [ -n "$tput" ]; then
  ncolors=$($tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi

### functions
# info: output terminal green
info() { 
  printf "%s" "$GREEN"
  echo -n "[+] "
  printf "%s" "$NORMAL"
  echo "$1"
}
# error: output terminal red
error() {
  printf "%s" "$RED"
  echo -n "[-] "
  printf "%s" "$NORMAL"
  echo "$1"
}
# warn: output terminal yellow
warn() {
  printf "%s" "$YELLOW"
  echo -n "[*] "
  printf "%s" "$NORMAL"
  echo "$1"
}
# log: out put termial normal
log() { 
  echo "  $1" 
}


# fix sed command diff between GNU & BSD
if sed --version 2>/dev/null | grep -q GNU; then
  alias sedi='sed -i '
else
  alias sedi='sed -i "" '
fi

# check package & return flag
is_exists() {
    which "$1" >/dev/null 2>&1
    return $?
}

# check bash version
is_bash() {
    [ -n "$BASH_VERSION" ]
}

# check package
has() {
  type "$1" > /dev/null 2>&1
}

# create symlink
symlink() {
  [ -e "$2" ] || ln -sf "$1" "$2"
}

# estimate os  
detect_os() {
  case "$(uname -s)" in
    Linux|GNU*)
      linux_distribution ;;
    Darwin)
      echo darwin ;;
    Windows|CYGWIN*|MSYS*|MINGW*)
      echo windows ;;
    *)
      echo unknown ;;
  esac
}

# estimate distribution name
linux_distribution() {
  if [ -f /etc/debian_version ]; then
    if [ "$(awk -F= '/DISTRIB_ID/ {print $2}' /etc/lsb-release)" = "Ubuntu" ]; then
      echo ubuntu
    else
      echo debian
    fi
  elif [ -f /etc/arch-release ]; then
    echo archlinux
  elif [[ -d /system/app/ && -d /system/priv-app ]]; then
    echo android
  else
    echo unkown_linux
  fi
}
