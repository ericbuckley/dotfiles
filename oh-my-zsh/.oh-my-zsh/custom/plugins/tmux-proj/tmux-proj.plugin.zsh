function ah () {
    cd $HOME/repos/$1
    tmux new-session -A -s $1 -c $PWD
    git s
}

function wwd () {
    cd $HOME/projects/wwd/code/wwd
    tmux new-session -A -s wwd
    workon wwd
    git s
}

function jbf () {
    cd $HOME/projects/jbf/jbf
    tmux new-session -A -s jbf
    workon jbf
    git s
}
