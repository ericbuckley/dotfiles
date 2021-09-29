# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="bullet-train"
BULLETTRAIN_PROMPT_ORDER=(
    virtualenv
    custom
    context
    dir
    git
    cmd_exec_time
)
BULLETTRAIN_PROMPT_CHAR='⟩'
BULLETTRAIN_CONTEXT_DEFAULT_USER='buckley'
BULLETTRAIN_VIRTUALENV_BG='black'
BULLETTRAIN_VIRTUALENV_FG='white'
BULLETTRAIN_NVM_BG='black'
BULLETTRAIN_NVM_FG='white'
BULLETTRAIN_AWS_BG='black'
BULLETTRAIN_AWS_FG='white'
BULLETTRAIN_DIR_BG='blue'
BULLETTRAIN_DIR_FG='black'
BULLETTRAIN_GIT_COLORIZE_DIRTY=true
BULLETTRAIN_GIT_BG='green'
BULLETTRAIN_GIT_DIRTY=''
BULLETTRAIN_GIT_CLEAN=''
BULLETTRAIN_GIT_ADDED=''
BULLETTRAIN_GIT_MODIFIED=''
BULLETTRAIN_GIT_DELETED=''
BULLETTRAIN_GIT_RENAMED=''
BULLETTRAIN_GIT_UNTRACKED=''


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

# virtualenv
export WORKON_HOME=$HOME/.venvs
export VIRTUALENVWRAPPER_PYTHON=`which python3`
DISABLE_VENV_CD=1

# nvm
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=true

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    gnu-utils
    virtualenvwrapper
    docker
    docker-compose
    github
    iterm2
    tmux
    aws
    doctl
    tmux-proj
    zsh-nvm
    common-aliases
    golang
    zsh-syntax-highlighting
    taskfile
)

source $ZSH/oh-my-zsh.sh
# zsh completion
fpath=(/usr/local/share/zsh-completions $fpath)

export PATH="$HOME/.local/bin:$PATH"
# configure QT path
export PATH="/usr/local/opt/qt/bin:$PATH"
# configure python path
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
# configure ruby path
export PATH="/usr/local/opt/ruby/bin:$PATH"
if type "gem" > /dev/null; then
    # configure ruby gem path
    export PATH="$(gem environment gemdir)/bin:$PATH"
fi
# configure gopath
export GOPATH="$HOME/.go"
# configure goroot on mac
if [ -d "/usr/local/opt/go" ]; then
    export GOROOT="$(brew --prefix golang)/libexec"
fi
# configure golang bin path
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"
# configure coreutils path on mac
if [ -d "/usr/local/opt/coreutils" ]; then
    export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
fi

# set default shell
export SHELL=`which zsh`

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

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
#########################

source $HOME/.aliases
