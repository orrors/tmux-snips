#!/usr/bin/env bash
# vi: foldmethod=marker

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
DEFAULT_DIR="$CURRENT_DIR/../snips"
CUSTOM_DIR=$1

# set previewer {{{
previewer="cat"
if hash bat 2>/dev/null ; then
    previewer="bat -fpl markdown"
elif hash batcat 2>/dev/null ; then
    previewer="batcat -fpl markdown"
fi
# }}}

# set editor {{{
editor="vim"
if hash nvim 2>/dev/null ; then
    editor="nvim"
fi
export editor # this variable must make into the fzf process
# }}}

# edit before copy function {{{
edit_before_copy() {
    FILE="$1"
    LINE="$2"
    TMP_FILE=$(mktemp)
    awk -v start="$LINE" '
        NR < start { next }
        NR > start && /^#+ / { exit }
        /^```/ {
            in_block = !in_block;
            if (!in_block) exit;
            next
        }
        in_block { print }' "$FILE" > "$TMP_FILE"
    $editor "$TMP_FILE"
    cat "$TMP_FILE" | tmux load-buffer -w -
    rm "$TMP_FILE"
}
export -f edit_before_copy
# }}}

# open in buffer function {{{
open_in_buffer() {
    FILE="$1"
    LINE="$2"
    TMP_FILE=$(mktemp)
    awk -v start="$LINE" '
        NR < start { next }
        NR > start && /^#+ / { exit }
        { print }' "$FILE" > "$TMP_FILE"
    $editor "$TMP_FILE"
    cat "$TMP_FILE" | tmux load-buffer -w -
    rm "$TMP_FILE"
}
export -f open_in_buffer 
# }}}

selection=$(rg --line-number --no-heading --color=always "^\s*##+ " $DEFAULT_DIR $CUSTOM_DIR | sed $'s/.*\/\([^./]\+\).md/\033[1;35m\\1\033[m:&/;s/##\+//' |
  fzf --ansi \
      --layout=reverse \
      --with-nth=1,4.. \
      --delimiter : \
      --preview "awk -v start={3} \"NR >= start { if (NR > start && \\\$0 ~ /^#+ /) exit; print }\" {2} | ${previewer}" \
      --preview-window=right:60%:wrap \
      --header=$'\033[1;33mctrl-b\033[m: open in buffer | \033[1;33mctrl-y\033[m: edit before copy | \033[1;33mctrl-e\033[m: edit file'  \
      --bind 'ctrl-e:execute(${editor} -R +{3} {2})+abort' \
      --bind 'ctrl-b:execute(open_in_buffer {2} {3})+abort' \
      --bind 'ctrl-y:execute(edit_before_copy {2} {3})+abort')

if [ -n "$selection" ] ; then
    FILE=$(echo "$selection" | cut -d: -f2)
    LINE=$(echo "$selection" | cut -d: -f3)
    awk -v start="$LINE" '
        NR < start { next }
        NR > start && /^#+ / { exit }
        /^```/ {
            in_block = !in_block;
            if (!in_block) exit;
            next
        }
        in_block { print }' "$FILE" |
            sed -z 's/^[ \t\n\r]*//;s/[ \t\n\r]*$//' | # trim
            tmux load-buffer -w -
fi
