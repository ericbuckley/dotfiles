function ah () {
    if [ ! -d "$HOME/repos/$1" ]
    then
        echo "$HOME/repos/$1 does not exist" >&2
    else
        cd $HOME/repos/$1
        tmux new-session -A -s $1 -c $PWD
        git s
    fi
}

function wwd () {
    cd $HOME/projects/wwd/code/wwd
    tmux new-session -A -s wwd
    workon wwd
    git s
}
