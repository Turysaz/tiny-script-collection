#!/bin/bash

td=temp #tempdir

mkdir $td
cd $td

echo "cloning airline"
echo "==============="

git clone https://github.com/vim-airline/vim-airline.git

echo "cloning airline themes"
echo "======================"
git clone https://github.com/vim-airline/vim-airline-themes.git

echo "cloning git branch info"
echo "======================="
git clone https://github.com/taq/vim-git-branch-info.git

echo
echo

echo "installing airline"
rsync vim-airline/ ~/.vim/

echo "installing airline themes"
rsync vim-airline-themes/ ~/.vim/

echo "installing  git branch info"
rsync vim-airline/ ~/.vim/

echo "install vimrc"
cp ../_vimrc-default ~/.vimrc


