#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/$HOME/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

# connect internet using blue
#SSID=`/System/Library/PrivateFrameworks/Apple80211.framework/Resources/airport -I | awk -F: '/ SSID/{print $2}'`
#if [ "$SSID" = ' blue' ]; then
#  export http_proxy=http://lv2east-proxy.nwdept:8080
#  export https_proxy=http://lv2east-proxy.nwdept:8080
#fi

# for pyenv
eval "$(pyenv init -)"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

export PATH="/usr/local/opt/sqlite/bin:$PATH"

# for pipenv
eval "$(pipenv --completion)"

# for direnv
eval "$(direnv hook zsh)"

# alias
alias gb="git branch"
alias gc="git checkout"
alias gl="git log"
alias gs="git status"
alias pm="python manage.py"
alias d="docker"
alias d-c="docker-compose"
alias dp="docker ps"
alias dpa="docker ps -a "
alias di="docker images"

# hub
eval "$(hub alias -s)"
