#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$CURRENT_DIR/../snips/"

previewer="cat"
if hash bat 2>/dev/null ; then
    previewer="bat -fpl markdown"
elif hash batcat 2>/dev/null ; then
    previewer="batcat -fpl markdown"
fi

rg --line-number --no-heading --color=always "^\s*#+ " . |
  fzf --ansi \
      --layout=reverse \
      --delimiter : \
      --preview "awk -v start={2} \"NR >= start { if (NR > start && \\\$0 ~ /^#+ /) exit; print }\" {1} | ${previewer}" \
      --preview-window=right:60%:wrap \
      --header=$'\033[1;33mctrl-e\033[m: edit file' \
      --bind 'ctrl-e:execute(vim +{2} {1})+abort' |
awk -F: '{print "+"$2" "$1}' |
xargs -r vim
