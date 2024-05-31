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
#
# Local binary PATH configuration
LOCALBIN="$HOME/.local/bin"
MYSCRIPT="$HOME/.local/my-sh" # my shell script collection
MYBINARY="$HOME/.local/my-bin"
export PATH="$PATH:$MYBINARY:$MYSCRIPT:$LOCALBIN"

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
	# GOPATH="$(go env GOPATH)"
	# GOBIN="$(go env GOPATH)/bin"
	# export PATH="$GOBIN:$PATH"
	export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"
fi

# Ruby PATH and binary PATH configuration
if command -v ruby &> /dev/null
then
	GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
	export PATH="$PATH:$GEM_HOME/bin"
fi

# Composer PATH configuration
if command -v composer &> /dev/null
then
	COMPOSER="$HOME/.config/composer/vendor/bin"
	export PATH="$PATH:$COMPOSER"
fi

# Aliases
alias sysleep='sudo systemctl hybrid-sleep'
alias dof='/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME' #dotfiles
alias nnn='nnn -e'
alias cb='xclip -sel clip'
alias vimfix='vim -p `git diff --name-only`' # -p open the files in separate tabs while git diff ... list the names of files that have changed
alias tx='tmux'

# alias pgst='sudo systemctl start postgresql.service'
# alias sctl='sudo systemctl'
# alias pgl='sudo su - postgres'

# fnm
#export PATH="$HOME/.local/share/fnm:$PATH"
#eval "`fnm env`"
