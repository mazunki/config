# auto colors
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'


# handy defaults
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias nl='nl -v 0'                        # start at 0

# overriding
alias vi='vim'
alias more=less

# scripts
alias cls="clear; echo -ne '\e[${LINES};0H'"
alias qgit="git add .; git commit -m 'quick commit' && git push"
alias pyid="echo -e '\tPID\t\tSource command\t\tArguments\n' && ps -o '<>%p<><>%c<><>%a' -e | grep python | head --lines=-1 | sed 's/<>/\\t/g' | sed 's/\/.* //g'"
alias emacs="echo 'What are you doing? git gud, use vim' && echo '' && sleep 2; vim"


# custom shortcuts
alias l="ls -al | less"
alias py="/usr/bin/python3 -B"
alias dog="/usr/bin/pygmentize" # /usr/lib/python3.6/site-packages/pygments
alias dir="cat ~/gits/mybash/quotes/richard_stallman.txt && echo '' && sleep 2; l"
alias rip="kill -9"
alias bye="sudo shutdown now"
alias brb="sudo reboot now"
