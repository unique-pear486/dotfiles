#!/bin/bash

# dotfiles deployment file

# Install useful programs if -p option is called
if [[ "$1" = "-p" ]]
then
    ./packages.sh
fi

# Git settings
git config --global core.excludesfile ~/.cvsignore
git config --global user.name "unique-pear486"
git config --global user.email "unique-pear486@users.noreply.github.com"
git config --global push.default simple

# vim settings
mkdir -p ~/.vim/tmp

# install and pull submodules
git submodule update --init --recursive
git submodule update --recursive

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
    ~/.vim/bundle/jedi-vim \
    ~/.vim/bundle/solarized \
    ~/.vim/autoload/vim-pathogen \
    ~/.vim/bundle/vim-fugitive \
    ~/.vim/bundle/tagbar \
    ~/.vim/bundle/tcomment_vim \
    ~/.vim/bundle/vim-surround \
    ~/.vim/bundle/supertab \
    ~/.bashrc \
    ~/.pythonrc.py \
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
