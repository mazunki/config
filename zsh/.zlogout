#!/bin/zsh
# Read in login shell, at logout

echo "Sourcing zlogout... bye~!"
[ "$(tty)" = "/dev/tty1" ] || exit

echo "Shutting down user services"
s6-rc -l "${XDG_RUNTIME_DIR}/s6/s6-rc" -b -da change

# What's the opposite
# s6-rc-init -c "${HOME}/.local/s6/compiled" -l "${XDG_RUNTIME_DIR}/s6/s6-rc" "${XDG_RUNTIME_DIR}/s6/service"
echo "Deleting compiled service references"
/bin/rm -rf -- "${XDG_RUNTIME_DIR}"/s6/service

echo "Shutting down usertree"
doas s6-rc -d change usertree-mazunki

echo "Cleaning up logs"
[ -d /home/mazunki/.local/logs/s6.old ] && /bin/rm -r -- /home/mazunki/.local/logs/s6.old
[ -d /home/mazunki/.local/logs/s6 ] && /bin/mv -T -- /home/mazunki/.local/logs/s6 /home/mazunki/.local/logs/s6.old

sleep 2

