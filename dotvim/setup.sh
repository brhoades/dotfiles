#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
ln -s ${DIR} ${HOME}/.vim
ln -s ${DIR}/../dotvimrc ${HOME}/.vimrc

mkdir ${HOME}/.vim/swaps
mkdir ${HOME}/.vim/backups
mkdir ${HOME}/.vim/undo

# Install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Install vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
vim +PluginInstall +qall
