#!/bin/sh

BASEDIR=$(dirname $0)

ln -s $BASEDIR/bashrc ~/.bashrc
ln -s $BASEDIR/bin ~/.bin
ln -s $BASEDIR/gitconfig ~/.gitconfig
ln -s $BASEDIR/gvimrc ~/.gvimrc
ln -s $BASEDIR/hgrc ~/.hgrc
ln -s $BASEDIR/jshintrc ~/.jshintrc
ln -s $BASEDIR/pdbrc ~/.pdbrc
ln -s $BASEDIR/pythonrc.py ~/.pythonrc.py
ln -s $BASEDIR/tmux.conf ~/.tmux.conf
ln -s $BASEDIR/vimrc ~/.vimrc

$BASEDIR/vim/plugins.sh
