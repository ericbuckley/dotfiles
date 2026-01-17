#!/usr/bin/env sh

if [ "$(tmux display-message -p -F "#{session_name}")" = "scratch" ]; then
    tmux detach-client
else
    tmux display-popup -E "tmux new-session -A -s scratch"
fi
