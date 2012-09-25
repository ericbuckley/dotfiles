#!/bin/bash

cd "${HOME}/.dotfiles"

# Pull down the latest changes
# git pull origin master

# Check out submodules
git submodule --quiet update --init

cd "${OLDPWD}"

function mirrorfiles() {
    # Copy .gitconfig
    # Any global git commands in ~/.extra will be written to .gitconfig
    # This prevents them being committed to the repository
    rsync -avz --quiet ${HOME}/.dotfiles/gitconfig  ${HOME}/.gitconfig

    # Symlink everything else
    # bash_profile sources other files from the repository
    # Force remove the vim directory if it is already there
    if [ -e "${HOME}/.vim" ]; then
        rm -rf "${HOME}/.vim"
    fi
    ln -fs ".dotfiles/ackrc"              "${HOME}/.ackrc"
    ln -fs ".dotfiles/bashrc"             "${HOME}/.bashrc"
    ln -fs ".dotfiles/bin"                "${HOME}/.bin"
    ln -fs ".dotfiles/gitconfig"          "${HOME}/.gitconfig"
    ln -fs ".dotfiles/hgrc"               "${HOME}/.hgrc"
    ln -fs ".dotfiles/jshintrc"           "${HOME}/.jshintrc"
    ln -fs ".dotfiles/pdbrc"              "${HOME}/.pdbrc"
    ln -fs ".dotfiles/pythonrc.py"        "${HOME}/.pythonrc.py"
    ln -fs ".dotfiles/tmux.conf"          "${HOME}/.tmux.conf"
    ln -fs ".dotfiles/vim"                "${HOME}/.vim"
    ln -fs ".dotfiles/vim/gvimrc"         "${HOME}/.gvimrc"
    ln -fs ".dotfiles/vim/vimrc"          "${HOME}/.vimrc"

    echo "Dotfiles update complete"
}

read -p "This will overwrite some existing files in your home directory. Are you sure? (y/n) " -n 1
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    mirrorfiles
    source ~/.bashrc
fi
