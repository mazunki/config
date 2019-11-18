GIT_BRANCH() {
  git branch 2>/dev/null | grep '^*' | colrm 1 2
}
GIT_STATUS() {
	git status 2>/dev/null
}
GET_BRANCH() {
	if [[ ! -z $(GIT_STATUS) ]]; then
		if [[ $(GIT_STATUS) =~ "nothing to commit, working tree clean" ]]; then
			if [[ $(GIT_STATUS) =~ "ahead" ]]; then
				if [ -z $1 ]; then
					echo -en "${MAGENTA}[${LGREEN}$(GIT_BRANCH)*${MAGENTA}]${RESTORE}"
				else
					echo -n "ahead";
				fi
			else
				if [ -z $1 ]; then
					echo -en "${MAGENTA}[${LGREEN}$(GIT_BRANCH)${MAGENTA}]${RESTORE}"
				else
					echo -n "clear";
				fi
			fi


		elif [[ $(GIT_STATUS) =~ "behind" ]]; then
			if [ -z $1 ]; then
				echo -en "${MAGENTA}[${LRED}$(GIT_BRANCH)${MAGENTA}]${RESTORE}"
			else
				echo -n "behind";
			fi
		elif [[ $(GIT_STATUS) =~ "Changes not staged" ]]; then
			if [ -z $1 ]; then
				echo -en "${MAGENTA}[${LYELLOW}$(GIT_BRANCH)*${MAGENTA}]${RESTORE}"
			else
				echo -n "unstaged";
			fi
		else
			if [ -z $1 ]; then
				echo -en "${MAGENTA}[${LYELLOW}$(GIT_BRANCH)${MAGENTA}]${RESTORE}"
			else
				echo -n "uncommited";
			fi
		fi
	fi
}