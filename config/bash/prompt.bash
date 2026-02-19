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
export PROMPT_DIRTRIM=2

###############################################################################
# Icons
###############################################################################

readonly ICON_HOME="󱂵"
readonly ICON_DIR="󰉋"
readonly ICON_DESKTOP="󰉖"        # Desktop
readonly ICON_DOWNLOAD="󰉍"       # Downloads
readonly ICON_DOCUMENT="󱧶"       # Documents
readonly ICON_MUSIC="󱍙"          # Music
readonly ICON_PICTURE="󰉏"        # Pictures
readonly ICON_VIDEO="󱧺"          # Videos
readonly ICON_CONFIG="󱁿"         # .config, .dotfiles
readonly ICON_TRASH=""          # Trash
readonly ICON_ROOT=""           # Root (/)

readonly ICON_USER=""
readonly ICON_HOST=""
readonly ICON_SSH="󰢹"
readonly ICON_VENV="󰆧"
readonly ICON_JOBS="󱑑"

readonly ICON_OK=""
readonly ICON_FAIL=""
readonly ICON_LOCK=""
readonly ICON_NOT_FOUND=""
readonly ICON_STOP=""

readonly ICON_OCTOCAT=""
# shellcheck disable=SC2034
readonly ICON_GIT_BITBUCKET=""
# shellcheck disable=SC2034
readonly ICON_GIT_GITLAB=""

readonly ICON_GIT_BRANCH=""
readonly ICON_GIT_COMMIT=""
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

###############################################################################
# Helpers
###############################################################################

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

###############################################################################
# Build Prompt (PROMPT_COMMAND)
###############################################################################

__build_prompt() {
  local exit_code=$?

  # 1. User
  local user_color="${BLUE}"
  [[ ${USER:-} == root ]] && user_color="${ORANGE}"
  local p_user="${user_color}${ICON_USER} ${BOLD}\u${RESET} "

  # 2. Host
  local host_color="${CYAN}"
  local host_icon="${ICON_HOST}"
  if [[ -n "${SSH_CLIENT:-}" || -n "${SSH_TTY:-}" ]]; then
    host_color="${ORANGE}"
    host_icon="${ICON_SSH}"
  fi
  local p_host="${host_color}${host_icon} ${BOLD}\h${RESET} "

  # 3. Dir
  local dir_icon="${ICON_DIR}"
  case "$PWD" in
    "$HOME") 
      dir_icon="${ICON_HOME}" 
      ;;
    "$HOME"/Desktop|"$HOME"/Desktop/*)     
      dir_icon="${ICON_DESKTOP}" 
      ;;
    "$HOME"/Downloads|"$HOME"/Downloads/*) 
      dir_icon="${ICON_DOWNLOAD}" 
      ;;
    "$HOME"/Documents|"$HOME"/Documents/*) 
      dir_icon="${ICON_DOCUMENT}" 
      ;;
    "$HOME"/Music|"$HOME"/Music/*)         
      dir_icon="${ICON_MUSIC}" 
      ;;
    "$HOME"/Pictures|"$HOME"/Pictures/*)   
      dir_icon="${ICON_PICTURE}" 
      ;;
    "$HOME"/Videos|"$HOME"/Videos/*|"$HOME"/Movies|"$HOME"/Movies/*) 
      dir_icon="${ICON_VIDEO}" 
      ;;
    "$HOME"/.config|"$HOME"/.config/*|"$HOME"/.dotfiles|"$HOME"/.dotfiles/*|/etc|/etc/*) 
      dir_icon="${ICON_CONFIG}" 
      ;;
    "$HOME"/.local/share/Trash*) 
      dir_icon="${ICON_TRASH}" 
      ;;
    /) 
      dir_icon="${ICON_ROOT}" 
      ;;
    *)
      dir_icon="${ICON_DIR}"
      ;;
  esac
  local p_dir="${GREEN}${dir_icon} ${BOLD}\w${RESET} "

  # 4. Git
  local git_info
  git_info="$(prompt_git)"
  local p_git="${git_info:+${YELLOW}${git_info}${RESET}}"

  # 5. Environment (uv / Python venv / mise)
  local p_venv=""
  local env_str=""

  # --- uv / Python venv ---
  if [[ -n "${VIRTUAL_ENV:-}" ]]; then
    local venv_name
    venv_name="$(basename "${VIRTUAL_ENV}")"
    if [[ "$venv_name" == ".venv" || "$venv_name" == "venv" ]]; then
      venv_name="$(basename "$(dirname "${VIRTUAL_ENV}")")"
    fi
    env_str+="${BLUE}${ICON_VENV} ${venv_name}${RESET} "
  fi

  # --- mise ---
  if [[ -n "${MISE_ENV:-}" ]]; then
    local icon_mise="" 
    env_str+="${CYAN}${icon_mise} ${MISE_ENV}${RESET} "
  fi
  p_venv="${env_str}"

  # 6. Job
  local p_jobs=""
  local jobs_count
  jobs_count=$(jobs -p | wc -l)
  if [[ $jobs_count -gt 0 ]]; then
    p_jobs="${CYAN}${ICON_JOBS} ${jobs_count}${RESET} "
  fi

  # 7. Result
  local p_result=""
  case "$exit_code" in
    0)   p_result=" ${ICON_OK}" ;;
    126) p_result=" ${ICON_LOCK}" ;;
    127) p_result=" ${ICON_NOT_FOUND}" ;;
    130) p_result=" ${ICON_STOP}" ;;
    *)   p_result=" ${ICON_FAIL} ${BOLD}${exit_code}${RESET}" ;;
  esac
  p_result="${YELLOW}${p_result}${RESET}"

  PS1="${p_venv}${p_user}${p_host}${p_dir}${p_git}${p_jobs}${p_result}\n$ "
}

export PROMPT_COMMAND="__build_prompt"
