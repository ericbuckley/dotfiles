# Dotfiles

My dotfiles.

## Getting started

### Prerequisites (optional)
#### required
* git

#### optional
* awscli
* neovim
* python3
* tmux
* vim
* zsh
* ripgrep
* virtualenvwrapper
* powerline font


### Installation

The following script will symlink **most** of the files underneath the top level
directories, the symlinks will be create in the homedir relative to where they are
stored.  For example the file `vim/.config/nvim.init` will get symlinked to
`~/.config/nvim.init`.  However any file named `init.script` will be executed
as a shell script rather than symlinked.

```
./install.sh
```
