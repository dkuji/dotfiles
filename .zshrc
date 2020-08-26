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
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

export PATH="/usr/local/opt/sqlite/bin:$PATH"

# for pipenv
eval "$(pipenv --completion)"
export PIPENV_VENV_IN_PROJECT=true

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
alias tp="terraform plan"

# hub
eval "$(hub alias -s)"

# include files
if [ -f ~/.env-dotfiles ]; then
  source ~/.env-dotfiles
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '~/google-cloud-sdk/path.zsh.inc' ]; then . '~/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '~/google-cloud-sdk/completion.zsh.inc' ]; then . '~/google-cloud-sdk/completion.zsh.inc'; fi

# molecule
eval "$(_MOLECULE_COMPLETE=source molecule)"

# tfenv
export PATH="$HOME/.tfenv/bin:$PATH"

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /home/dkuji/.tfenv/versions/0.12.29/terraform terraform
