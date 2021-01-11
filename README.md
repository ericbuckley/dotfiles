# Dotfiles

My dotfiles.

## Getting started

### Prerequisites (optional)
#### required
* git

#### optional
* coreutils
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

### Post Installation

After opening [n]vim and install the plugins
  ```
  vim
  :PlugInstall
  ```
Open a new tmux session and install the tpm plugins
  ```
  ts test
  <ctrl-a> I
  ```
