#!/bin/bash

# install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle;
curl -so ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim

# install command-T
cd ~/.vim/bundle;
git clone https://github.com/wincent/Command-T.git
