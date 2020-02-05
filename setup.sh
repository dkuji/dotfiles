#!/bin/bash

# add submodule
git submodule update --init --recursive

DOT_FILES=(
    .zprezto
    .gitconfig 
)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

# change shell
chsh -s $(which zsh)
