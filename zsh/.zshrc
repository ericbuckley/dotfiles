# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Path for local installs
export PATH="$HOME/.local/bin:$PATH"
if [[ "$(uname -m)" == "arm64" ]]; then
  # Path of homebrew installation on Apple Silicon
  export PATH="/opt/homebrew/bin:$PATH"
fi

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder


# disable software flow control [ctrl-s/ctrl-q]
#stty ixoff -ixon
#stty stop undef
#stty start undef
stty start '^-' stop '^-'

# keybinding
bindkey "^[b" backward-word
bindkey "^[f" forward-word

# virtualenv
export WORKON_HOME=$HOME/.venvs
export VIRTUALENVWRAPPER_PYTHON=`which python3`

# pipx
export PIPX_HOME=$HOME/.pipx

# nvm
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

# gem
export GEM_HOME=~/.gem
export GEM_PATH=~/.gem

# golang
export GOPATH="$HOME/.golang"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
#    virtualenv
    docker
    docker-compose
    podman
    tmux
    aws
    azure
    common-aliases
    zsh-syntax-highlighting
    # custom plugins
    tmux-proj
    atuin
)

# pure prompt
FPATH="$FPATH:$HOME/.config/zsh/pure"
autoload -U promptinit; promptinit
prompt pure
zstyle :prompt:pure:git:branch color green
zstyle :prompt:pure:git:dirty color magenta

# zsh completion
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
else
    FPATH="/usr/local/share/zsh/site-functions:${FPATH}"
fi
source $ZSH/oh-my-zsh.sh

# configure paths for mac homebrew setup
if type brew &>/dev/null; then
    # configure QT path
    export PATH="$(brew --prefix)/opt/qt/bin:$PATH"
    # configure golang paths
    export GOROOT="$(brew --prefix)/opt/go/libexec"
    export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
    # configure python path
    export PATH="$(brew --prefix)/opt/python@3.12/libexec/bin:$PATH"
    # configure coreutils path
    export PATH="$(brew --prefix)/opt/coreutils/libexec/gnubin:$PATH"
    # configure grep path
    export PATH="$(brew --prefix)/opt/grep/libexec/gnubin:$PATH"
    # configure java
    export PATH="$(brew --prefix)/opt/openjdk/bin:$PATH"
fi

# fly.io configuration
export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"

# User configuration
export DEFAULT_USER='buckley'
# You may need to manually set your language environment
export LANG=en_US.UTF-8
# Compilation flags
export ARCHFLAGS="-arch x86_64"
# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi
export GPG_TTY=$(tty)
# colors
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
#########################
source $HOME/.aliases

# load any host specific zsh configurations
test -e "${HOME}/.zshrc.local" && source "${HOME}/.zshrc.local"
