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

selection=$(rg --line-number --no-heading --color=always "^\s*##+ " . |
  fzf --ansi \
      --layout=reverse \
      --delimiter : \
      --preview "awk -v start={2} \"NR >= start { if (NR > start && \\\$0 ~ /^#+ /) exit; print }\" {1} | ${previewer}" \
      --preview-window=right:60%:wrap \
      --header=$'\033[1;33mctrl-e\033[m: edit file | \033[1;33mctrl-y\033[m: edit before copy' \
      --bind 'ctrl-e:execute(${editor} -R +{2} {1})+abort' \
      --bind 'ctrl-y:execute(edit_before_copy {1} {2})+abort')

if [ -n "$selection" ] ; then
    FILE=$(echo "$selection" | cut -d: -f1)
    LINE=$(echo "$selection" | cut -d: -f2)
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
