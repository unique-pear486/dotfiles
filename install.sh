#!/bin/bash

# dotfiles deployment file

# Install useful programs
## apt-get install vim

# Git settings
git config --global core.excludesfile ~/.cvsignore

# vim settings
mkdir -p ~/.vim/tmp

# install and pull submodules
git submodule init
git submodule update

# make links from location to dotfiles
read -p 'old-dotfiles will be overwritten! OK? ' yn
case $yn in
    [Yy]* ) mv old-dotfiles/.gitignore /tmp/; \
            rm -rf old-dotfiles/; \
            mkdir old-dotfiles/; \
            mv /tmp/.gitignore old-dotfiles/;;
    * ) exit;;
esac
for filename in \
    ~/.vimrc \
    ~/.vim/autoload/pathogen.vim  \
    ~/.cvsignore \
    ~/.inputrc \
    ~/.vim/bundle/python-mode \
    ;
do
    if [ -L $filename ]
    then
        rm $filename
    elif [ -a $filename ]
    then
        mv $filename old-dotfiles/
        echo moving ${filename##*/} to old-dotfiles/
    fi
    mkdir -p ${filename%/*}
    ln -s $(pwd)/${filename##*/} ${filename%/*}
done
