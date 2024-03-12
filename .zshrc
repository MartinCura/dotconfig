##PS4='+ $(date "+%s.%N")\011 '
##exec 3>&2 2>/tmp/zshstart.$$.log
##set -x
####zmodload zsh/zprof

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
#export ZSH="/home/martin/.oh-my-zsh"
export ZSH="/usr/share/oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="random"  # "robbyrussell" "cloud"
ZSH_THEME_RANDOM_QUIET=true

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Opposite to previous option (can't be used together)
ZSH_THEME_RANDOM_IGNORED=( "adben" "amuse" "wuffers" "evan" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

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
#plugins=(git aws bundler docker docker-compose cp heroku rbenv rvm rake battery)
plugins=(git docker docker-compose cp poetry)

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

export EDITOR=nano

# Enable bashcompinit for completions
autoload -U +X bashcompinit && bashcompinit

# Re-run last command but with sudo
alias fuck='sudo $(history -p \!\!)'

# virtualenvwrapper
#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/Code
#export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
#export VIRTUALENVWRAPPER_VIRTUALENV=$HOME/.local/bin/virtualenv
##source $HOME/.local/bin/virtualenvwrapper.sh
#source $HOME/.local/bin/virtualenvwrapper_lazy.sh

# activate local venv assuming it's in .venv/
#alias activ='if [ -n $(source .venv/bin/activate) ]; then source ../.venv/bin/activate; fi'
alias activ='source .venv/bin/activate'

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
#alias vertmon='source /home/martin/.screenlayout/vertical-two-monitor.sh'

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
#eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh --daemonize)
#export SSH_AUTH_SOCK

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

# pipenv ~ don't use it anymore and it takes too much time
# pipenv completion
#eval "$(pipenv --completion)"
#
# pipenv auto shell
#function auto_pipenv_shell {
#	if [ ! -n "${PIPENV_ACTIVE+1}" ]; then
#		if [ -f "Pipfile" ] ; then
#			pipenv shell
#		fi
#	fi
#}
#function cd {
#	builtin cd "$@"
#	auto_pipenv_shell
#}
#auto_pipenv_shell
#
# pipenv venv in project dir
#export PIPENV_VENV_IN_PROJECT=1

# GPG key
export GPG_TTY=$(tty)
# run gpg-agent (redundant somewhere?)
eval $(gpg-agent --daemon 2> >(grep -v "already running"))

# scaled spotify
alias spotify='spotify --force-device-scale-factor=1.5'
# scaled zoom
#alias zoom='QT_SCALE_FACTOR=1.5 zoom'

alias dj='python manage.py'

# giving root access to docker is dangerous; an alias so i don't forget sudo is fine
alias docker='sudo docker'
alias docker-compose='sudo docker-compose'

# Geckodriver
export PATH=$PATH:$HOME"/Code/zetc/selenium_experiments/geckodriver-v0.27.0-linux64"

# Go (lang)
export PATH=$PATH:/usr/local/go/bin

# nvm ~ takes too much time to load but some things need it
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
function enable_nvm_completion {
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
}
autoload -U add-zsh-hook
load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use --silent
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    nvm use default --silent
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc

# dat
export PATH="$PATH:/home/martin/.dat/releases/dat-14.0.2-linux-x64"

# Terraform
complete -o nospace -C /usr/bin/terraform terraform

alias nv='nvim'

# Rust
. "$HOME/.cargo/env"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# pipx
export PATH="$PATH:/home/martin/.local/bin"
eval "$(register-python-argcomplete pipx)"


## set +x
##exec 2>&3 3>&-

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# aws' instructions for kubectl made me do this
export PATH="$HOME/bin:$PATH"

# kubectl autocompletion
source <(kubectl completion zsh)

#alias code='codium'

alias sshk='kitty +kitten ssh'

## docker rootless
#export DOCKER_HOST=unix://$XDG_RUNTIME_DIR/docker.sock

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# rvm
source ~/.rvm/scripts/rvm
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# bat
alias cat='bat'
batdiff() {
    git diff --name-only --relative --diff-filter=d | xargs bat --diff
}
#export MANPAGER="sh -c 'col -bx | bat -l man -p'"
alias bathelp='bat --plain --language=help'
help() {
    "$@" --help 2>&1 | bathelp
}


# pnpm
export PNPM_HOME="/home/martin/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
source ~/.rvm/scripts/rvm

# bun completions
[ -s "/home/martin/.bun/_bun" ] && source "/home/martin/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# edgedb
fpath+=~/.zfunc

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/google-cloud-sdk/completion.zsh.inc'; fi

# autojump
[[ -s /usr/share/autojump/autojump.zsh ]] && source /usr/share/autojump/autojump.zsh

# SSH agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent -t 1w > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi

compinit
