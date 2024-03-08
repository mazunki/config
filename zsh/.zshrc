#!/bin/zsh
# .zshrc
test -f /etc/profile && . /etc/profile

for subconf in "${ZDOTDIR}"/conf.d/*; do
	case "$subconf" in
		*.disabled) continue ;;
		*) source "${subconf}" ;;
	esac
done

