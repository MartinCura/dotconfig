##PS4='+ $(date "+%s.%N")\011 '
##exec 3>&2 2>/tmp/zshstart.$$.log
##set -x
###zmodload zsh/zprof

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/martin/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="random"  # "robbyrussell" "cloud"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git aws bundler docker docker-compose cp heroku rbenv rvm rake battery)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# ####################################################################

HISTSIZE=10000000
SAVEHIST=$HISTSIZE

# Re-run last command but with sudo
alias fuck='sudo $(history -p \!\!)'

# virtualenvwrapper
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Code
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.local/bin/virtualenv
#source $HOME/.local/bin/virtualenvwrapper.sh
source $HOME/.local/bin/virtualenvwrapper_lazy.sh

# activate local venv assuming it's in .venv/
#alias activ='if [ -n $(source .venv/bin/activate) ]; then source ../.venv/bin/activate; fi'
alias activ='source .venv/bin/activate'

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Android variables for React Native tools
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Buck
export PATH=$PATH:/opt/buck/bin

# Flutter
export PATH=$PATH:/opt/flutter/bin

# Vertical screen setup script
alias vertmon='source /home/martin/.screenlayout/vertical-two-monitor.sh'

# Editor for React
export REACT_EDITOR=atom

# Countdown with alarm
alias countdown='alarm_countdown.sh'

# Insist on 'git status' alias to take precedence over ghostscript
alias gs='git status'

# dotconfig to version control local config
alias dotconfig='/usr/bin/git --git-dir=$HOME/.home/ --work-tree=$HOME'

# pywal
#(cat ~/.cache/wal/sequences &)

# ssh-agent with gnome-keyring
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh --daemonize)
export SSH_AUTH_SOCK

# Disable ^S as SIGSTOP because i like it as a quicksave (such as in Vim)
stty -ixon

# Use transfer.sh for easy upload-and-share
transfer() {
	if [ $# -eq 0 ]; then
		echo -e "No arguments specified. Usage:\necho transfer /tmp/test.md\ncat /tmp/test.md | transfer test.md"
		return 1
	fi
	tmpfile=$( mktemp -t transferXXX )
	if tty -s; then
		basefile=$(basename "$1" | sed -e 's/[^a-zA-Z0-9._-]/-/g')
		curl --progress-bar --upload-file "$1" "https://transfer.sh/$basefile" >> $tmpfile
	else
		curl --progress-bar --upload-file "-" "https://transfer.sh/$1" >> $tmpfile
	fi
	cat $tmpfile
	rm -f $tmpfile
}

# CUDA bin
export PATH="$PATH:/usr/local/cuda-10.2/bin"

# pipenv completion
eval "$(pipenv --completion)"

# pipenv auto shell
function auto_pipenv_shell {
	if [ ! -n "${PIPENV_ACTIVE+1}" ]; then
		if [ -f "Pipfile" ] ; then
			pipenv shell
		fi
	fi
}
function cd {
	builtin cd "$@"
	auto_pipenv_shell
}
auto_pipenv_shell

# GPG key
export GPG_TTY=$(tty)
# run gpg-agent (redundant somewhere?)
eval $(gpg-agent --daemon 2> >(grep -v "already running"))

# scaled spotify
alias spotify='spotify --force-device-scale-factor=1.5'
# scaled zoom
alias zoom='QT_SCALE_FACTOR=1.5 zoom'

alias dj='python manage.py'

##set +x
##exec 2>&3 3>&-
