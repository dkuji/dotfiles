#!/bin/bash

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
    .gitconfig 
)

for file in ${DOT_FILES[@]}
do
    ln -sf $HOME/dotfiles/$file $HOME/$file
done

# change shell
chsh -s $(which zsh)
