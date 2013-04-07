CLICOLOR=1
GREP_OPTIONS='--color=auto'

alias tmux='tmux -2'
alias tmn='tmux new -s $1'
alias tma='tmux attach -t $1'

source ~/.git-prompt.sh

# git
GIT_PS1_SHOWDIRTYSTATE=yes
GIT_PS1_SHOWSTASHSTATE=yes
GIT_PS1_SHOWUNTRACKEDFILES=yes

hg_ps1() {
    hg prompt "{ on {branch}}{ at {bookmark}}{status}" 2> /dev/null
}

PS1='\u at \h in \w$(__git_ps1 " (%s)")$(hg_ps1)\n$ '
export PS1

# . /usr/local/lib/python2.7/site-packages/powerline/bindings/bash/powerline.sh

case $OSTYPE in
darwin*)
    export LC_CTYPE=en_US.UTF-8
    export LC_ALL=en_US.UTF-8
    export DYLD_LIBRARY_PATH=/usr/local/mysql/lib

    ### Added by the Heroku Toolbelt
    export PATH="/usr/local/heroku/bin:$PATH"

    alias ls='ls -G'
    ;;
esac
