#!/usr/bin/env bash
# vi: foldmethod=marker

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$CURRENT_DIR/../snips/"

# set previewer {{{
previewer="cat"
if hash bat 2>/dev/null ; then
    previewer="bat -fpl markdown"
elif hash batcat 2>/dev/null ; then
    previewer="batcat -fpl markdown"
fi
# }}}

selection=$(rg --line-number --no-heading --color=always "^\s*##+ " . |
  fzf --ansi \
      --layout=reverse \
      --delimiter : \
      --preview "awk -v start={2} \"NR >= start { if (NR > start && \\\$0 ~ /^#+ /) exit; print }\" {1} | ${previewer}" \
      --preview-window=right:60%:wrap \
      --header=$'\033[1;33mctrl-e\033[m: edit file | \033[1;33mctrl-y\033[m: edit before copy' \
      --bind 'ctrl-e:execute(vim +{2} {1})+abort' \
      --bind 'ctrl-y:execute(echo NOT IMPLEMENTED)+abort')

if [ -n "$selection" ] ; then
    local FILE=$(echo "$selection" | cut -d: -f1)
    local LINE=$(echo "$selection" | cut -d: -f2)
    local TMP_FILE=$(mktemp)
    awk -v start="$LINE" '
        NR < start { next }
        NR > start && /^#+ / { exit }
        /^```/ {
            in_block = !in_block;
            if (!in_block) exit;
            next
        }
        in_block { print }
    ' "$FILE" > "$TMP_FILE"
    vim "$TMP_FILE"
    cat "$TMP_FILE" | tmux load-buffer -w -
    rm "$TMP_FILE"
fi
