#!/bin/bash

# dotfiles deployment file

usage() { 
    echo "Usage: $0 OPTION[S]"
    echo
    echo "OPTIONS are:"
    echo "  -s      change system settings"
    echo "  -p      install packages"
    echo "  -d      install dotfiles"
    exit 1
}

dotfiles() {
    # Git settings
    git config --global core.excludesfile ~/.cvsignore
    git config --global user.name "unique-pear486"
    git config --global user.email "unique-pear486@users.noreply.github.com"
    git config --global push.default simple
    git config --global alias.hist 'log --graph --full-history --all --pretty=format:"%Cred%h%Creset %ad %<(40,trunc) %s %C(yellow)%d%Creset %C(bold blue)<%an>%Creset" --date=short'
    git config --global init.templatedir '~/.git_template'

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
        ~/.vim/bundle/syntastic \
        ~/.bashrc \
        ~/.pythonrc.py \
        ~/.abcde.conf \
        ~/.git_template \
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
}

while getopts "pds" o; do
    case "${o}" in
        s)
            ./system.sh;;
        p)
            ./packages.sh;;
        d)
            dotfiles;;
        *)
            usage
            exit 1;;
    esac
done

if [ $OPTIND -eq 1 ]; then
    usage
fi
