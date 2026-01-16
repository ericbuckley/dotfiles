ZDOTDIR=${ZDOTDIR:-$HOME}

# Path for local installs
export PATH="$HOME/.local/bin:$PATH"
# configure homebrew
if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# default eza params
_EZA_PARAMS=('--git' '--group' '--group-directories-first' '--time-style=long-iso' '--color-scale=all')

# initialize antidote
source ${ZDOTDIR}/.antidote/antidote.zsh
source <(antidote init)
# install zsh plugins
antidote bundle <<EOF
sindresorhus/pure

atuinsh/atuin
MichaelAquilina/zsh-you-should-use
z-shell/zsh-eza
fdellwing/zsh-bat

getantidote/use-omz
ohmyzsh/ohmyzsh path:plugins/git
ohmyzsh/ohmyzsh path:plugins/docker
ohmyzsh/ohmyzsh path:plugins/tmux

zsh-users/zsh-syntax-highlighting
zsh-users/zsh-autosuggestions
EOF

# pure prompt
zstyle :prompt:pure:git:branch color green
zstyle :prompt:pure:git:dirty color magenta


# faster zsh completion startup
autoload -Uz compinit
if [[ -n ${ZDOTDIR}/.zcompdump(#qNmh+24) ]]; then
    compinit
else
    compinit -C
fi

# configure paths for mac homebrew setup
if type brew &>/dev/null; then
    # configure python path
    export PATH="${HOMEBREW_PREFIX}/opt/python@3.13/libexec/bin:$PATH"
    # configure java path
    export JAVA_HOME="${HOMEBREW_PREFIX}/opt/openjdk/libexec/openjdk.jdk/Contents/Home"
    export PATH="${JAVA_HOME}/bin:$PATH"
    # configure golang paths
    export GOROOT="${HOMEBREW_PREFIX}/opt/go/libexec"
    export GOPATH="$HOME/.golang"
    export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
    # configure coreutils path
    export PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:$PATH"
    # configure grep path
    export PATH="${HOMEBREW_PREFIX}/opt/grep/libexec/gnubin:$PATH"
fi

# Default editor
export EDITOR='nvim'
# You may need to manually set your language environment
export LANG=en_US.UTF-8
# gpg
export GPG_TTY=$(tty)

# For a full list of active aliases, run `alias`.
[[ -f "$HOME/.aliases" ]] && source $HOME/.aliases
# load any host specific zsh configurations
[[ -f "${HOME}/.zshrc.local" ]] && source "${HOME}/.zshrc.local"

# remove duplicate entries in PATH
typeset -U path
