#!/bin/zsh
# .zshrc
test_and_source() {
	test $# -ge 1 || printf '[warn] test_and_source: %s\n' "nothing to source"
	for file; do
		test -f "$file" ||
			printf '[warn] test_and_source: %s\n' "could not source: '$1'"
		# printf "sourcing '%s'\n" "${file}"
		. "${file}"
	done
}

# test_and_source /etc/profile
test_and_source "${XDG_CONFIG_HOME:-${HOME}/.config}/environment" 
test_and_source "${XDG_CONFIG_HOME:-${HOME}/.config}/aliases" 
test_and_source "${ZDOTDIR}/.zshenv" 

for subconf in "${ZDOTDIR}"/conf.d/*; do
	case "$subconf" in
		*.disabled) continue ;;
		.*) continue ;;
		*) test_and_source "${subconf}" ;;
	esac
done


# . /usr/share/zsh/plugins/zshz

