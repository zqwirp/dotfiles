#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

# History control
export HISTCONTROL=$HISTCONTROL:ignoredups
export HISTCONTROL=$HISTCONTROL:ignorespace

# Environment
export EDITOR='vim'

# Java program workaround config
if command -v java &> /dev/null
then
	export _JAVA_AWT_WM_NONREPARENTING=1
fi

# NPM prefix configuration
if command -v npm &> /dev/null
then
	# To allow global package installations for the current user
	export npm_config_prefix="$HOME/.local" # https://wiki.archlinux.org/title/node.js_#Allow_user-wide_installations
fi

# GO Language PATH and binary PATH configuration
if command -v go &> /dev/null
then
	export GOPATH=$(go env GOPATH)
	export GOBIN="$(go env GOPATH)/bin"
	export PATH="$GOBIN:$PATH"
fi

# Ruby PATH and binary PATH configuration
if command -v ruby &> /dev/null
then
	export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
	export PATH="$GEM_HOME/bin:$PATH"
fi

# Local binary PATH configuration
export LOCALBIN="$HOME/.local/bin"
export MYBIN="$HOME/.local/sh" # my shell script collection
export PATH="$MYBIN:$LOCALBIN:$PATH"

# Aliases
alias sctl='sudo systemctl'
alias sysleep='sudo systemctl hybrid-sleep'
alias pgst='sudo systemctl start postgresql.service'
alias pgl='sudo su - postgres'
alias confix='vim -p `git diff --name-only`'
alias dof='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME' #dotfiles
alias nnn='nnn -e'
alias cb='xclip -sel clip'
