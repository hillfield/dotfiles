#
# ~/.bashrc
#
alias edit=vim

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export LANG=en_GB.UTF-8
export LC_MESSAGES="C"
export LC_CTYPE="en_GB.UTF-8"
export LC_COLLATE="C"
export LC_MESSAGES="en_GB.utf8"

