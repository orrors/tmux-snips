#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$CURRENT_DIR/../snips/"

if hash bat 2>/dev/null ; then
    previewer="bat --style=numbers --color=always --highlight-line {2} --line-range {2}: {1}"
elif hash batcat 2>/dev/null ; then
    previewer="batcat --style=numbers --color=always --highlight-line {2} --line-range {2}: {1}"
else
    previewer="cat -n {1}"
fi

rg --line-number --no-heading --color=always . |
fzf --ansi \
    --layout=reverse \
    --delimiter ':' \
    --preview "$previewer" \
    --preview-window=right:60%:wrap \
    --header=$'\033[1;33mctrl-e\033[m: edit file' \
    --bind 'ctrl-e:execute(nvim +{2} {1})+abort' \
    |
awk -F: '{print "+"$2" "$1}' |
xargs -r nvim
