#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
alias update='sudo pacman -Syyuv'
alias fish='asciiquarium'
alias home='cd ~'
alias lsd='ls -ld `find . -maxdepth 1 -type d -o -type l`'
alias ls='ls -l -a'
alias reload='. ~/.bash_profile'
