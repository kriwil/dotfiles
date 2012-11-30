alias tmux='tmux -2'
alias tmn='tmux new -s $1'
alias tma='tmux attach -t $1'

PS1='\u@\h \W$(__git_ps1 " (%s)")\$ '
