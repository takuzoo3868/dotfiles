#!/usr/bin/env bash

if [[ $COLORTERM = gnome-* && $TERM = xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
	export TERM='gnome-256color';
elif infocmp xterm-256color >/dev/null 2>&1; then
	export TERM='xterm-256color';
fi;

if tput setaf 1 &> /dev/null; then
	tput sgr0; # reset colors
	bold=$(tput bold);
	reset=$(tput sgr0);

	black=$(tput setaf 234);
	blue=$(tput setaf 27);
	cyan=$(tput setaf 39);
	green=$(tput setaf 76);
	orange=$(tput setaf 166);
	purple=$(tput setaf 125);
	red=$(tput setaf 124);
	violet=$(tput setaf 61);
	white=$(tput setaf 15);
	yellow=$(tput setaf 154);
else
	bold='';
	reset="\e[00m";
	black="\e[1;30m";
	blue="\e[1;34m";
	cyan="\e[1;36m";
	green="\e[1;32m";
	orange="\e[1;33m";
	purple="\e[1;35m";
	red="\e[1;31m";
	violet="\e[1;35m";
	white="\e[1;37m";
	yellow="\e[1;33m";
fi;

export PROMPT_DIRTRIM=2

# icons set
ICON_HOME=""
ICON_DIR=""
ICON_ETC=""
ICON_USER=""
ICON_HOST=""

ICON_OK=""
ICON_FAIL=""
ICON_LOCK=""
ICON_NOT_FOUND=""
ICON_STOP=""

ICON_OCTOCAT=""
ICON_GIT_BITBUCKET=""
ICON_GIT_GITLAB=""

ICON_GIT_BRANCH=""
ICON_GIT_COMMIT=""
ICON_GIT_REMOTE_BRANCH=""
ICON_GIT_UNTRACKED=""
ICON_GIT_UNSTAGED=""
ICON_GIT_STAGED=""
ICON_GIT_STASH=""
ICON_GIT_INCOMING_CHANGES=""
ICON_GIT_OUTGOING_CHANGES=""
ICON_GIT_TAG=""

# git status veiw
prompt_git() {
	local s='';
	local branchName='';
	local gitHash='';

	GIT_DIR="$(git rev-parse --git-dir 2>/dev/null)"

	# Check if the current directory is in a Git repository.
	if [ $(git rev-parse --is-inside-work-tree &>/dev/null; echo "${?}") == '0' ]; then

		# check if the current directory is in .git before running git checks
		if [ "$(git rev-parse --is-inside-git-dir 2> /dev/null)" == 'false' ]; then

			# Ensure the index is up to date.
			git update-index --really-refresh -q &>/dev/null;

			# Check for uncommitted changes in the index.
			if ! $(git diff --quiet --ignore-submodules --cached); then
				s+=${ICON_GIT_STAGED};
			fi;

			# Check for unstaged changes.
			if ! $(git diff-files --quiet --ignore-submodules --); then
				s+=${ICON_GIT_UNSTAGED};
			fi;

			# Check for untracked files.
			if [ -n "$(git ls-files --others --exclude-standard)" ]; then
				s+=${ICON_GIT_UNTRACKED};
			fi;

			# Check for stashed files.
			if $(git rev-parse --verify refs/stash &>/dev/null); then
				s+=${ICON_GIT_STASH};
			fi;

		fi;

		# Get the short symbolic ref.
		# If HEAD isn’t a symbolic ref, get the short SHA for the latest commit
		# Otherwise, just give up.
		branchName=" ${ICON_GIT_BRANCH} $(git symbolic-ref --quiet --short HEAD 2> /dev/null || \
			git rev-parse --short HEAD 2> /dev/null || \
			echo '(unknown)')";

		[ -n "${s}" ] && s=" ${s}";

		# Get commit hash
		gitHash=" ${ICON_GIT_COMMIT} $(git rev-parse --short HEAD)";


		echo -e "${ICON_OCTOCAT}${1}${branchName}${gitHash}${2}${s}";
	else
		return;
	fi;
}

prompt_dir_icon(){
	case $PWD in
	    $HOME)
	        echo ${ICON_HOME}
		    ;;
		"/etc")
		    echo ${ICON_ETC}
			;;
        *) 
	        echo ${ICON_DIR}
		    ;;
	esac
}

prompt_user(){
	if [[ "${USER}" == "root" ]]; then
	    user_state="${orange}";
    else
	    user_state="${blue}";
    fi;

	# the hostname when connected via SSH.
    if [[ "${SSH_TTY}" ]]; then
	    hostStyle="${bold}${red}";
    else
	    hostStyle="${yellow}";
    fi;

	echo -e "${user_state}${ICON_USER}"
}

prompt_host(){
	echo -e "${cyan}${ICON_HOST}"
}

prompt_result() {
  code=$?
  if [ ${code} == 0 ]; then
    echo -e "${ICON_OK}";
  elif [ ${code} == 126 ]; then
    echo -e "${ICON_LOCK}";            # Command invoked cannot execute
  elif [ ${code} == 127 ]; then
    echo -e "${ICON_NOT_FOUND}";       # Command not found
  elif [ ${code} == 130 ]; then
    echo -e "${ICON_STOP}";            # Script terminated by Control-C
  else
    echo -e "${ICON_FAIL} ${bold}${code}${reset}";
  fi;
}

# Set the terminal title and prompt.
PS1=" ";
PS1+="\$(prompt_user) \[${bold}\]\u ";
PS1+="\[${reset}\]";
PS1+="\$(prompt_host) \[${bold}\]\h ";
PS1+="\[${reset}\]";
PS1+="\[${green}\]\$(prompt_dir_icon) \[${bold}\]\w ";
PS1+="\[${reset}\]";
PS1+="\[${yellow}\]\$(prompt_git) ";
PS1+="\[${reset}\]";                                        
PS1+="\[${yellow}\]\$(prompt_result)";
PS1+="\[${reset}\]";                                    
PS1+="\n";
PS1+="\$ ";                            
export PS1;
