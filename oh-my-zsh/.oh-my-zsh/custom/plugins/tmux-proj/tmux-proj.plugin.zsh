function ah () {
    cd $HOME/projects/adhoc/code/$1
    tmux attach -t $1 || tmux new-session -s $1 -c $PWD
    git s
}

function wwd () {
    cd $HOME/projects/wwd/code/wwd
    tmux attach -t wwd || tmux new-session -s wwd
    workon wwd
    git s
}

function jbf () {
    cd $HOME/projects/jbf/jbf
    tmux attach -t jbf || tmux new-session -s jbf
    workon jbf
    git s
}
