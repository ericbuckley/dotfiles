#!/bin/bash

cp vimrc ~/.vimrc

# install pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle;
curl -so ~/.vim/autoload/pathogen.vim \
    https://raw.github.com/tpope/vim-pathogen/HEAD/autoload/pathogen.vim

cd ~/.vim/bundle;
# install plugins
git clone https://github.com/wincent/Command-T.git
git clone https://github.com/mileszs/ack.vim.git
git clone https://github.com/manalang/jshint.vim.git; cd jshint/; rake install; cd ../;
git clone https://github.com/scrooloose/nerdcommenter.git
git clone https://github.com/fs111/pydoc.vim.git
git clone https://github.com/garbas/vim-snipmate.git
git clone https://github.com/honza/snipmate-snippets.git
git clone https://github.com/scrooloose/syntastic.git
git clone git://github.com/majutsushi/tagbar.git
git clone https://github.com/tomtom/tlib_vim.git
git clone https://github.com/smerrill/vagrant-vim.git
git clone https://github.com/MarcWeber/vim-addon-mw-utils.git
git clone https://github.com/altercation/vim-colors-solarized.git
git clone https://github.com/skammer/vim-css-color.git
git clone https://github.com/leshill/vim-json.git
git clone https://github.com/rodjek/vim-puppet.git
git clone https://github.com/tpope/vim-repeat.git
git clone https://github.com/tsaleh/vim-supertab.git
git clone https://github.com/tpope/vim-surround.gitapt
