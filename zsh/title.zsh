
function title {
	setopt localoptions nopromptsubst

# Don't set the title if inside emacs, unless using vterm
[[ -n "${INSIDE_EMACS:-}" && "$INSIDE_EMACS" != vterm ]] && return

# if $2 is unset use $1 as default
# if it is set and empty, leave it as is
: ${2=$1}

case "$TERM" in
	screen*|tmux*)
		print -Pn "\ek${1:q}\e\\" # set screen hardstatus
		;;
	*)
		print -Pn "\e]2;${2:q}\a" # set window name
		print -Pn "\e]1;${1:q}\a" # set tab name
esac
}

function set_title_preexec {
	emulate -L zsh
	setopt extended_glob

	# split command into array of arguments
	local -a cmdargs
	cmdargs=("${(z)2}")
	# if running fg, extract the command from the job description
	if [[ "${cmdargs[1]}" = fg ]]; then
		# get the job id from the first argument passed to the fg command
		local job_id jobspec="${cmdargs[2]#%}"
		# logic based on jobs arguments:
		# http://zsh.sourceforge.net/Doc/Release/Jobs-_0026-Signals.html#Jobs
		# https://www.zsh.org/mla/users/2007/msg00704.html
		case "$jobspec" in
			<->) # %number argument:
				# use the same <number> passed as an argument
				job_id=${jobspec} ;;
			""|%|+) # empty, %% or %+ argument:
				# use the current job, which appears with a + in $jobstates:
				# suspended:+:5071=suspended (tty output)
				job_id=${(k)jobstates[(r)*:+:*]} ;;
			-) # %- argument:
				# use the previous job, which appears with a - in $jobstates:
				# suspended:-:6493=suspended (signal)
				job_id=${(k)jobstates[(r)*:-:*]} ;;
			[?]*) # %?string argument:
				# use $jobtexts to match for a job whose command *contains* <string>
				job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]} ;;
			*) # %string argument:
				# use $jobtexts to match for a job whose command *starts with* <string>
				job_id=${(k)jobtexts[(r)${(Q)jobspec}*]} ;;
		esac

		# override preexec function arguments with job command
		if [[ -n "${jobtexts[$job_id]}" ]]; then
			1="${jobtexts[$job_id]}"
			2="${jobtexts[$job_id]}"
		fi
	fi

	# cmd name only, or if this is sudo or ssh, the next cmd
	local CMD="${1[(wr)^(*=*|ssh|doas|-*)]:gs/%/%%}"
	local LINE="${2:gs/%/%%}"

	title "$ZSH_THEME_TERM_TITLE_IDLE $CMD" \
		"%100>...>$ZSH_THEME_TERM_TAB_TITLE_IDLE $LINE%<<"
}

function clear_title_precmd {
	print -Pn "\e]0;zsh :: ${PWD} \a"
}

add-zsh-hook preexec set_title_preexec
add-zsh-hook precmd clear_title_precmd

