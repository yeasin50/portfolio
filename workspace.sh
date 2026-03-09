#!/usr/bin/env bash

SESSION="portfolio_session"
DIR="$(pwd)"

# Create session and run server
tmux new-session -d -s "$SESSION" -c "$DIR" -n win1
tmux send-keys -t "$SESSION:win1" "make server" C-m

# Create second window
tmux new-window -t "$SESSION" -n win2 -c "$DIR"

# Top pane
tmux send-keys -t "$SESSION:win2.1" "make generate" C-m

# Bottom pane
tmux split-window -v -t "$SESSION:win2" -c "$DIR"
tmux send-keys -t "$SESSION:win2.2" "make run" C-m

# Attach only if not already inside tmux
if [ -z "$TMUX" ]; then
  tmux attach -t "$SESSION"
else
  tmux switch-client -t "$SESSION"
fi
