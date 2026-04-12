#!/usr/bin/env bash
 
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
tmux bind-key C-q display-popup -EE "$CURRENT_DIR/scripts/snips.sh"
tmux bind-key q display-popup -EE "$CURRENT_DIR/scripts/snips.sh"

