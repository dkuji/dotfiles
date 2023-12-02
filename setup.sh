#!/bin/zsh
set -x

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
  [ ! -h $HOME/$file ] && ln -sf $HOME/dotfiles/$file $HOME/$file
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

# screen shot 
mkdir ~/screenshot
defaults write com.apple.screencapture name "ScreenShot"
defaults write com.apple.screencapture location ~/screenshot/;killall SystemUIServer

# brew install
brew install \
  direnv \
  postgresql

brew cask install  \
  alfred \
  docker \
  google-chrome \
  google-japanese-ime \
  iterm2 \
  slack \
  visual-studio-code \
  zoomus \
  deepl \
  macs-fan-control

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
( 
  cd /tmp/ && 
  curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-304.0.0-darwin-x86_64.tar.gz &&
  tar xvzf google-cloud-sdk-304.0.0-darwin-x86_64.tar.gz &&
  ./google-cloud-sdk/install.sh
)

# install aws-cli
if [ ! -h /usr/local/bin/aws ]; then
cat <<EOF > /tmp/choices.xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <array>
    <dict>
      <key>choiceAttribute</key>
      <string>customLocation</string>
      <key>attributeSetting</key>
      <string>${HOME}</string>
      <key>choiceIdentifier</key>
      <string>default</string>
    </dict>
  </array>
</plist>
EOF
  ( 
    cd /tmp/ &&
    curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg" &&
    installer -pkg AWSCLIV2.pkg \
              -target CurrentUserHomeDirectory \
              -applyChoiceChangesXML choices.xml
  ) 
fi
[ -h /usr/local/bin/aws ] || sudo ln -s ~/aws-cli/aws /usr/local/bin/aws 
[ -h /usr/local/bin/aws_completer ] || sudo ln -s ~/aws-cli/aws_completer /usr/local/bin/aws_completer 

# install tfenv
[ -d ~/.tfenv ] || git clone https://github.com/tfutils/tfenv.git ~/.tfenv
