
cp _bash_aliases ~/.bash_aliases
cp _bash_functions.sh ~/.bash_functions.sh

mkdir ~/.bash
wget -O ~/.bash/git-completion.bash https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash
echo "source ~/.bash/git-completion.bash" >> ~/.bashrc

