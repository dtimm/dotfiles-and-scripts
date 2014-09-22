# .bashrc for David Timm, rev. 2014-02-17

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

alias df='df -h'
alias du='du -h'
alias grep='grep --color'
alias ls='ls -hF --color=tty'
alias jobs='jobs -l'

BLACK='\[\e[0;30m\]'
BLUE='\[\e[0;34m\]'
GREEN='\[\e[0;32m\]'
CYAN='\[\e[0;36m\]'
RED='\[\e[0;31m\]'
PURPLE='\[\e[0;35m\]'
BROWN='\[\e[0;33m\]'
LIGHTGRAY='\[\e[0;37m\]'
DARKGRAY='\[\e[1;30m\]'
LIGHTBLUE='\[\e[1;34m\]'
LIGHTGREEN='\[\e[1;32m\]'
LIGHTCYAN='\[\e[1;36m\]'
LIGHTRED='\[\e[1;31m\]'
LIGHTPURPLE='\[\e[1;35m\]'
YELLOW='\[\e[1;33m\]'
WHITE='\[\e[1;37m\]'
NC='\[\e[0m\]'

export PS1="${WHITE}\u${GREEN}@${WHITE}\h${NC}\w$ "
export EDITOR=vim
export SHELL=/bin/bash
