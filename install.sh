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
    git config --global alias.hist '!tput rmam; git log --graph --full-history --all --pretty=format:"%Cred%h%Creset %ad %<(40,trunc) %s %C(yellow)%d%Creset %C(bold blue)<%an>%Creset" --date=short; tput smam'
    git config --global alias.co checkout
    git config --global alias.st status
    git config --global alias.wipe '!git add -A && git commit -qm "WIPE SAVEPOINT" && git reset HEAD~1 --hard'
    git config --global init.templatedir '~/.git_template'

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
        ~/.cvsignore \
        ~/.inputrc \
        ~/.config/nvim/init.vim \
        ~/.vim/pack/git-plugins/start/ale \
        ~/.bashrc \
        ~/.pythonrc.py \
        ~/.abcde.conf \
        ~/.git_template \
        ~/.config/alacritty/alacritty.yml \
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

    # Install dein
    mkdir -p "~/.cache/dein/repos/github.com/Shougo/dein.vim"
    git clone https://github.com/Shougo/dein.vim "~/.cache/dein/repos/github.com/Shougo/dein.vim"
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
