function diffo() {
    diff $1 $2 | sed -n 's/^> \(.*\)/\1/p'
}

function tm() {
    tmux attach -t $1 || tmux new -s $1
}
