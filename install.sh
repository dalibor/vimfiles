#! /bin/bash

if [ -d ~/.vim ]; then
  echo "vimfiles already installed... skipping"
else
  # Install vim
  sudo apt-get install vim-nox -y # vim with ruby support
  sudo apt-get install exuberant-ctags ncurses-term xsel -y

  # Setup vimfiles
  git clone git://github.com/dalibor/vimfiles.git ~/.vim
  cd ~/.vim
  git submodule update --init
  echo "source ~/.vim/vimrc" > ~/.vimrc
fi
