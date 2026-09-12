ZDOTDIR=${ZDOTDIR:-$HOME}

# keep duplicate entries out of path
typeset -U path
# set default locale
export LANG=en_US.UTF-8
# path for local installs
export PATH="$HOME/.local/bin:$PATH"

# configure homebrew [optionally]
for brew_path in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [[ -x "$brew_path" ]]; then
        eval "$("$brew_path" shellenv)"; break
    fi
done
# eza settings
_EZA_PARAMS=('--git' '--group' '--icons' '--group-directories-first' '--time-style=long-iso' '--color-scale=all')
# pure prompt settings
zstyle :prompt:pure:git:branch color green
zstyle :prompt:pure:git:dirty color magenta
# omz settings
DISABLE_AUTO_UPDATE="true"
# docker settings
zstyle ':omz:plugins:docker' legacy-completion yes

# initialize antidote
source "${ZDOTDIR}/.antidote/antidote.zsh"
source <(antidote init)
# install zsh plugins
antidote bundle <<EOF
sindresorhus/pure

atuinsh/atuin
MichaelAquilina/zsh-you-should-use
z-shell/zsh-eza
fdellwing/zsh-bat
bigH/git-fuzzy path:bin kind:path

getantidote/use-omz
ohmyzsh/ohmyzsh path:plugins/git
ohmyzsh/ohmyzsh path:plugins/docker
ohmyzsh/ohmyzsh path:plugins/tmux
ohmyzsh/ohmyzsh path:plugins/kubectl

zsh-users/zsh-syntax-highlighting
zsh-users/zsh-autosuggestions
EOF

# faster zsh completion startup
autoload -Uz compinit
compinit -u ${${ZDOTDIR}/.zcompdump(#qNmh+24):+-C}

# configure paths for mac homebrew setup
if type brew &>/dev/null; then
    # disable auto updates
    export HOMEBREW_NO_AUTO_UPDATE=1
    # configure golang paths
    export GOROOT="${HOMEBREW_PREFIX}/opt/go/libexec"
    export GOPATH="$HOME/.golang"
    export PATH="$GOPATH/bin:$GOROOT/bin:$PATH"
    # configure coreutils path
    export PATH="${HOMEBREW_PREFIX}/opt/coreutils/libexec/gnubin:$PATH"
    # configure grep path
    export PATH="${HOMEBREW_PREFIX}/opt/grep/libexec/gnubin:$PATH"
fi

# configure mise
if type mise &>/dev/null; then
    eval "$(mise activate zsh)"
fi

# gpg
export GPG_TTY=$(tty)
# default editor
export EDITOR='nvim'
# pi configuration
export PI_CODING_AGENT_DIR="$HOME/.config/pi/agent"
# default bat settings
export PAGER='bat'
export BAT_STYLE='changes,grid,header-filename,snip'
export BAT_PAGING='never'
# Force Emacs keybindings (overrides EDITOR=nvim default)
bindkey -e

# For a full list of active aliases, run `alias`.
[[ -f "$HOME/.aliases" ]] && source "$HOME/.aliases"
# load any host specific zsh configurations
[[ -f "${HOME}/.zshrc.local" ]] && source "${HOME}/.zshrc.local"
