#!/bin/bash

td=temp #tempdir

echo creating temporary directory
mkdir $td
cd $td

echo ""
echo "cloning airline"
echo "==============="

git clone https://github.com/vim-airline/vim-airline.git

echo ""
echo "cloning airline themes"
echo "======================"
git clone https://github.com/vim-airline/vim-airline-themes.git

echo ""
echo "cloning git branch info"
echo "======================="
git clone https://github.com/taq/vim-git-branch-info.git

echo ""
echo "start installation"
echo ""

echo "installing airline"
rsync vim-airline/ ~/.vim/

echo "installing airline themes"
rsync vim-airline-themes/ ~/.vim/

echo "installing  git branch info"
rsync vim-airline/ ~/.vim/

echo "install vimrc"
cp ../_vimrc-default ~/.vimrc

echo
echo "installation complete"
echo

echo "removing temp dir"
cd ..
rm -rf $td

echo "NERDtree sill missing :("
echo "done."

