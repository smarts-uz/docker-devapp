# .bashrc

# User specific aliases and functions

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export PATH="/var/app/ALL/ALL/AZK:$PATH"

chmod 755 -R /var/app/ALL/ALL/*
chmod 755 -R /var/app/ALL/App/*
