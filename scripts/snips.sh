#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$CURRENT_DIR/../snips/"
rg --line-number --no-heading --color=always . |
fzf --ansi \
    --layout=reverse \
    --border=rounded \
    --delimiter ':' \
    --preview 'bat --style=numbers --color=always --highlight-line {2} {1}' \
    --preview-window=right:60%:wrap |
awk -F: '{print "+"$2" "$1}' |
xargs -r nvim
