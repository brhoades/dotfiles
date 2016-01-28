#!/bin/bash
DIR=$(dirname $(readlink -f $0))
ln -s $DIR ${HOME}/.vim
ln -s $DIR/../dotvimrc ${HOME}/.vimrc

mkdir -p ${HOME}/.vim/swaps ${HOME}/.vim/backups ${HOME}/.vim/undo

# Install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/vundle
printf "\n" | vim +PluginInstall +qall
cd ${HOME}/.vim/bundle/YouCompleteMe/
cmake .
python install.py
printf "\n" | vim +PluginInstall +qall
