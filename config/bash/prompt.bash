#!/usr/bin/env bash
#
# Author: takuzoo3868
# Last Modified: 9 Feb 2026.
#

###############################################################################
# Terminal capability
###############################################################################

if [[ ${COLORTERM:-} == gnome-* && ${TERM:-} == xterm ]] \
   && infocmp gnome-256color >/dev/null 2>&1; then
  export TERM='gnome-256color'
elif infocmp xterm-256color >/dev/null 2>&1; then
  export TERM='xterm-256color'
fi

###############################################################################
# Colors
###############################################################################

if tput setaf 1 >/dev/null 2>&1; then
  tput sgr0

  BOLD="$(tput bold)"
  RESET="$(tput sgr0)"

  BLUE="$(tput setaf 27)"
  CYAN="$(tput setaf 39)"
  GREEN="$(tput setaf 76)"
  ORANGE="$(tput setaf 166)"
  RED="$(tput setaf 124)"
  YELLOW="$(tput setaf 154)"
else
  BOLD=''
  RESET=$'\e[0m'

  BLUE=$'\e[1;34m'
  CYAN=$'\e[1;36m'
  GREEN=$'\e[1;32m'
  ORANGE=$'\e[1;33m'
  RED=$'\e[1;31m'
  YELLOW=$'\e[1;33m'
fi

readonly BOLD RESET BLUE CYAN GREEN ORANGE RED YELLOW
export BLUE CYAN GREEN ORANGE RED YELLOW
export PROMPT_DIRTRIM=2

###############################################################################
# Icons
###############################################################################

readonly ICON_HOME=""
readonly ICON_DIR=""
readonly ICON_ETC=""
readonly ICON_USER=""
readonly ICON_HOST=""

readonly ICON_OK=""
readonly ICON_FAIL=""
readonly ICON_LOCK=""
readonly ICON_NOT_FOUND=""
readonly ICON_STOP=""

readonly ICON_OCTOCAT=""
# shellcheck disable=SC2034
readonly ICON_GIT_BITBUCKET=""
# shellcheck disable=SC2034
readonly ICON_GIT_GITLAB=""

readonly ICON_GIT_BRANCH=""
readonly ICON_GIT_COMMIT=""
# shellcheck disable=SC2034
readonly ICON_GIT_REMOTE_BRANCH=""
readonly ICON_GIT_UNTRACKED=""
readonly ICON_GIT_UNSTAGED=""
readonly ICON_GIT_STAGED=""
readonly ICON_GIT_STASH=""
# shellcheck disable=SC2034
readonly ICON_GIT_INCOMING_CHANGES=""
# shellcheck disable=SC2034
readonly ICON_GIT_OUTGOING_CHANGES=""
# shellcheck disable=SC2034
readonly ICON_GIT_TAG=""

prompt_git() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return 0

  local status=''
  local branch
  local commit

  if [[ $(git rev-parse --is-inside-git-dir 2>/dev/null) == false ]]; then
    git update-index --really-refresh -q >/dev/null 2>&1 || true

    git diff --quiet --cached || status+="${ICON_GIT_STAGED}"
    git diff-files --quiet || status+="${ICON_GIT_UNSTAGED}"

    [[ -n $(git ls-files --others --exclude-standard) ]] \
      && status+="${ICON_GIT_UNTRACKED}"

    git rev-parse --verify refs/stash >/dev/null 2>&1 \
      && status+="${ICON_GIT_STASH}"
  fi

  branch="$(git symbolic-ref --quiet --short HEAD \
            || git rev-parse --short HEAD \
            || printf '(unknown)')"

  commit="$(git rev-parse --short HEAD)"

  printf '%s %s %s%s' \
    "${ICON_OCTOCAT}" \
    "${ICON_GIT_BRANCH} ${branch}" \
    "${ICON_GIT_COMMIT} ${commit}" \
    "${status:+ ${status}}"
}

prompt_dir_icon() {
  case "$PWD" in
    "$HOME") printf '%s' "${ICON_HOME}" ;;
    /etc)   printf '%s' "${ICON_ETC}" ;;
    *)      printf '%s' "${ICON_DIR}" ;;
  esac
}

prompt_user() {
  local color="${BLUE}"
  [[ ${USER:-} == root ]] && color="${ORANGE}"
  printf '%s%s' "${color}" "${ICON_USER}"
}

prompt_host() {
  printf '%s%s' "${CYAN}" "${ICON_HOST}"
}

prompt_result() {
  local code=$?
  case "$code" in
    0)   printf '%s' "${ICON_OK}" ;;
    126) printf '%s' "${ICON_LOCK}" ;;
    127) printf '%s' "${ICON_NOT_FOUND}" ;;
    130) printf '%s' "${ICON_STOP}" ;;
    *)   printf '%s %s%s%s' "${ICON_FAIL}" "${BOLD}" "$code" "${RESET}" ;;
  esac
}

###############################################################################
# PS1
###############################################################################

PS1=""
PS1+="\$(prompt_user) \[${BOLD}\]\u\[${RESET}\] "
PS1+="\$(prompt_host) \[${BOLD}\]\h\[${RESET}\] "
PS1+="\[${GREEN}\]\$(prompt_dir_icon) \[${BOLD}\]\w\[${RESET}\] "
PS1+="\[${YELLOW}\]\$(prompt_git)\[${RESET}\] "
PS1+="\[${YELLOW}\]\$(prompt_result)\[${RESET}\]"
PS1+=$'\n$ '

export PS1
