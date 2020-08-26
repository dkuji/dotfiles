#!/bin/zsh
#set -x

# add submodule
git submodule update --init --recursive

# setup prezto
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
    ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done

DOT_FILES=(
    .zshrc
    .zpreztorc
    .zprezto
)

for file in ${DOT_FILES[@]}
do
  [ ! -h $HOME/$file ] || ln -sf $HOME/dotfiles/$file $HOME/$file
done

if [ ! -h $HOME/.gitconfig ]; then
  ln -s $HOME/dotfiles/.gitconfig $HOME/.gitconfig
fi

# change shell
if [[ ${SHELL} =~ "zsh" ]]; then
  true
else
  chsh -s $(which zsh)
fi

# brew install
brew install \
  direnv

brew cask install  \
  alfred \
  docker \
  google-chrome \
  google-japanese-ime \
  iterm2 \
  slack \
  visual-studio-code \
  zoomus \
  deepl

# vscode
vscode_extensions=(
  tabnine.tabnine-vscode
  ms-python.python
  alefragnani.project-manager
  vscodevim.vim
  redhat.vscode-yaml
)
for e in ${vscode_extensions[@]}
do
  code --install-extension $e
done

# install pyenv
if [ ! -d ~/.pyenv ]; then
  git clone https://github.com/pyenv/pyenv.git ~/.pyenv
  . ~/.zshrc
fi

# install pipenv
#pyenv shell system
#pyenv --versions
pip3 show pipenv || sudo pip3 install pipenv

# install gcloud
command -v gcloud || \
( cd /tmp/ && \
  curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-304.0.0-darwin-x86_64.tar.gz && \
  tar xvzf google-cloud-sdk-304.0.0-darwin-x86_64.tar.gz && \
  ./google-cloud-sdk/install.sh
)

# install aws-cli
