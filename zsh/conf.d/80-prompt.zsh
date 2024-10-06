#!/bin/zsh

function check_if_git_behind() {
	git status -sb 2> /dev/null | grep -s 'behind' 2>&1 > /dev/null
	if [ "$?" -ne "0" ]; then
		GIT_BEHIND_STR=''
	else
		GIT_BEHIND_STR="%F{124}●%f"
	fi
	RPROMPT="$GIT_BEHIND_STR"
}
function format_path() {
	if [ -z "${PROJECT_ROOT}" ]; then
		path_str='%F{69}%~%f'
	else
		if [ "${PWD}" = "${PROJECT_ROOT}" ]; then
			_path_str="${PROJECT_ICON:-...}${PROJECT_ICON:+ }${PROJECT_NAME}: %~"
		elif [[ "${PWD}" == "${PROJECT_ROOT}"* ]]; then
			_path_str=".../${PWD#${PROJECT_ROOT}/}"
		else
			_path_str=".../$(realpath --relative-to="${PROJECT_ROOT}" "${PWD}")"
		fi
		path_str="%F{69}${_path_str}%f"
	fi
}
function format_hostname() {
	if [ -z "$SSH_TTY" ]; then
		hostname_str=''
	else
		hostname_str=" @ %F{127}%m%f"
	fi
}
function format_exit_code() {
	_exit_code_last_cmd=$?
	if [[ "${_was_empty}" == "1" ]]; then
		exit_code_str=''
		unset _was_empty
	elif [[ "${_exit_code_last_cmd}" == 0 ]]; then
		exit_code_str=''
	else
		exit_code_str="[%F{196}${_exit_code_last_cmd}%f] "
	fi
}
function reset_exitcode_on_empty() {
	if [[ -z "$BUFFER" ]]; then
		_was_empty=1
	fi

	zle .accept-line
}
function set_title() {
	if [ -z "${PROJECT_NAME}" ]; then
		_title="zsh:$(basename "${PWD}")"
		print -Pn "\e]2;${_title}\a"
	else
		_title="${PROJECT_ICON}${PROJECT_ICON+ }${PROJECT_NAME}"
		print -Pn "\e]2;${_title}\a"
	fi
}

function find_project_root() {
	unset PROJECT_ROOT PROJECT_RESIDENCE PROJECT_NAME PROJECT_ICON
	while IFS='|' read -r icon name pattern; do
		for dir in ${(M)~pattern}; do
			if [ "${PWD}" = "${dir}" ] || [[ "${PWD}" == "${dir}"/* ]]; then
				export PROJECT_ROOT="${dir}"
				export PROJECT_RESIDENCE="$(dirname "${dir}")"
				if [ "${name}" = '*' ]; then
					name="$(basename "${dir}")"
				fi
				export PROJECT_NAME="${name}"
				export PROJECT_ICON="${icon}"
			fi
		done
	done < "${XDG_CONFIG_HOME:-$HOME/.config}"/projects.list
}

autoload -Uz add-zsh-hook vcs_info
setopt PROMPT_SUBST
zle -N accept-line reset_exitcode_on_empty

add-zsh-hook precmd format_exit_code
add-zsh-hook precmd format_path
add-zsh-hook precmd format_hostname
add-zsh-hook precmd vcs_info
add-zsh-hook precmd set_title

add-zsh-hook chpwd find_project_root
find_project_root


# %b is branch, %u is unstagedstr, %c is staged
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '%F{196}'
zstyle ':vcs_info:*' stagedstr '%F{226}'
zstyle ':vcs_info:*' behindstr '%F{124}!!%f'

zstyle ':vcs_info:git:*' formats       '(%F{046}%c%u%b%f%f) '
zstyle ':vcs_info:git:*' actionformats '(%b|%a%u%c) '

export NEWLINE=$'\n'
rightarrow=$(echo -en '\u27f6')
export PROMPT='${exit_code_str}${vcs_info_msg_0_}${path_str}${hostname_str}${NEWLINE}'
zle_highlight=(default:bold,fg=127)


