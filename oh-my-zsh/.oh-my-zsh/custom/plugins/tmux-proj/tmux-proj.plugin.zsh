function ah () {
    cd $HOME/projects/adhoc/code/$1
    tmux attach -t $1 || tmux new-session -s $1 -c $PWD
    git s
}

function ahh () {
    NUM=$(basename -s .zip $1)
    DIR=$HOME/Downloads/homework/$NUM
    mkdir -p $DIR
    mv $1 $DIR
    unzip $DIR/${NUM}.zip -d $DIR/
    cd $DIR
    tmux attach -t $1 || tmux new-session -s homework -c $DIR
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
