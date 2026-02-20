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
  BOLD="\[$(tput bold)\]"
  RESET="\[$(tput sgr0)\]"

  BLUE="\[$(tput setaf 27)\]"
  CYAN="\[$(tput setaf 39)\]"
  GREEN="\[$(tput setaf 76)\]"
  ORANGE="\[$(tput setaf 208)\]"
  RED="\[$(tput setaf 203)\]"
  YELLOW="\[$(tput setaf 154)\]"
  PURPLE="\[$(tput setaf 135)\]"
  GRAY="\[$(tput setaf 242)\]"
else
  BOLD=''
  RESET='\[\e[0m\]'

  BLUE='\[\e[1;34m\]'
  CYAN='\[\e[1;36m\]'
  GREEN='\[\e[1;32m\]'
  ORANGE='\[\e[1;33m\]'
  RED='\[\e[1;31m\]'
  YELLOW='\[\e[1;33m\]'
  PURPLE='\[\e[1;35m\]'
  GRAY='\[\e[1;30m\]'
fi

readonly BOLD RESET BLUE CYAN GREEN ORANGE RED YELLOW PURPLE GRAY
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

readonly ICON_GIT=""
readonly ICON_OCTOCAT=""
readonly ICON_GIT_BITBUCKET=""
readonly ICON_GIT_GITLAB=""

readonly ICON_GIT_BRANCH=""
readonly ICON_GIT_COMMIT=""
readonly ICON_GIT_UNTRACKED=""
readonly ICON_GIT_UNSTAGED=""
readonly ICON_GIT_STAGED=""
readonly ICON_GIT_STASH=""

readonly ICON_TIME=""
readonly ICON_EXEC_TIME="󱫌"

###############################################################################
# Helpers
###############################################################################

trap 'timer_start=${timer_start:-$SECONDS}' DEBUG

prompt_git() {
  local rev_info
  rev_info="$(git rev-parse --absolute-git-dir --is-inside-git-dir 2>/dev/null)"
  [[ -z "$rev_info" ]] && return 0

  local git_dir="${rev_info%$'\n'*}"
  local is_inside="${rev_info#*$'\n'}"

  [[ "$is_inside" == "true" ]] && return 0

  local provider_icon="${ICON_GIT}"
  if [[ -f "$git_dir/config" ]]; then
    while IFS= read -r line; do
      if [[ "$line" == *url\ =* ]]; then
        if [[ "$line" == *bitbucket* ]]; then
          provider_icon="${ICON_GIT_BITBUCKET}"
        elif [[ "$line" == *gitlab* ]]; then
          provider_icon="${ICON_GIT_GITLAB}"
        elif [[ "$line" == *github* ]]; then
          provider_icon="${ICON_OCTOCAT}"
        fi
        break
      fi
    done < "$git_dir/config"
  fi

  local status=''
  local branch
  local commit

  branch="$(git branch --show-current 2>/dev/null)"
  [[ -z "$branch" ]] && branch="(detached)"
  
  commit="$(git rev-parse --short HEAD 2>/dev/null)"
  [[ -z "$commit" ]] && commit="(new)"

  local git_status
  git_status="$(git --no-optional-locks status --porcelain 2>/dev/null)"

  if [[ -n "$git_status" ]]; then
    local is_staged=0 is_unstaged=0 is_untracked=0
    while IFS= read -r line; do
      [[ ${line:0:2} == "??" ]] && is_untracked=1
      [[ ${line:0:1} != " " && ${line:0:1} != "?" ]] && is_staged=1
      [[ ${line:1:1} != " " && ${line:1:1} != "?" ]] && is_unstaged=1
      [[ $is_staged -eq 1 && $is_unstaged -eq 1 && $is_untracked -eq 1 ]] && break
    done <<< "$git_status"

    [[ $is_staged -eq 1 ]] && status+=" ${ICON_GIT_STAGED}"
    [[ $is_unstaged -eq 1 ]] && status+=" ${ICON_GIT_UNSTAGED}"
    [[ $is_untracked -eq 1 ]] && status+=" ${ICON_GIT_UNTRACKED}"
  fi
  
  [[ -f "$git_dir/refs/stash" || -f "$git_dir/logs/refs/stash" ]] && status+=" ${ICON_GIT_STASH}"

  printf '%s' \
    "${provider_icon}  ${ICON_GIT_BRANCH}  ${branch} ${ICON_GIT_COMMIT}  ${commit}${status}"
}

###############################################################################
# Build Prompt (PROMPT_COMMAND)
###############################################################################

__build_prompt() {
  local exit_code=$?

  # 0. Exec Time
  local p_exec_time=""
  if [[ -n "${timer_start:-}" ]]; then
    local duration=$((SECONDS - timer_start))
    unset timer_start
    if [[ $duration -ge 2 ]]; then
      p_exec_time="${ORANGE}${ICON_EXEC_TIME}  ${duration}s${RESET} "
    fi
  fi

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
  local p_dir="${GREEN}${dir_icon}  ${BOLD}\w${RESET} "

  # 4. Git
  local p_git=""
  local git_info
  git_info="$(prompt_git)"
  if [[ -n "$git_info" ]]; then
    p_git="${YELLOW}${git_info}${RESET}  "
  fi

  # 5. Environment (uv / Python venv / mise)
  local p_venv=""
  local env_str=""

  # --- uv / Python venv ---
  if [[ -n "${VIRTUAL_ENV:-}" ]]; then
    local venv_name="${VIRTUAL_ENV##*/}"
    if [[ "$venv_name" == ".venv" || "$venv_name" == "venv" ]]; then
      local parent_dir="${VIRTUAL_ENV%/*}"
      venv_name="${parent_dir##*/}"
    fi
    env_str+="${PURPLE}${ICON_VENV} ${BOLD}${venv_name}${RESET} "
  fi

  # --- mise ---
  if [[ -n "${MISE_ENV:-}" ]]; then
    local icon_mise="" 
    env_str+="${PURPLE}${icon_mise} ${BOLD}${MISE_ENV}${RESET} "
  fi
  p_venv="${env_str}"

  # 6. Job
  local p_jobs=""
  local current_jobs=($(jobs -p 2>/dev/null))
  local jobs_count=${#current_jobs[@]}
  if [[ $jobs_count -gt 0 ]]; then
    p_jobs="${CYAN}${ICON_JOBS} ${jobs_count}${RESET} "
  fi

  # 7. Result
  local p_result=""
  case "$exit_code" in
    0)   p_result="${GRAY}${ICON_OK}${RESET}  " ;;
    126) p_result="${ORANGE}${ICON_LOCK}${RESET}  " ;;
    127) p_result="${ORANGE}${ICON_NOT_FOUND}${RESET}  " ;;
    130) p_result="${ORANGE}${ICON_STOP}${RESET}  " ;;
    *)   p_result="${RED}${ICON_FAIL} ${BOLD}${exit_code}${RESET}  " ;;
  esac

  # 8. Time
  local p_time="${GRAY}${ICON_TIME} \t${RESET}"

  PS1="${p_venv}${p_user}${p_host}${p_dir}${p_git}${p_jobs}${p_exec_time}${p_result}${p_time}\n$ "
}

export PROMPT_COMMAND="__build_prompt"
