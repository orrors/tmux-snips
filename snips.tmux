#!/usr/bin/env bash
 
key_option="@snips-key"

default_key='C-q'
CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
default_snips_dir="$CURRENT_DIR/scripts/snips.sh"

get_tmux_option() {
    local option="$1"
    local default_value="$2"
    local option_value=$(tmux show-option -gqv "$option")
    if [ -z "$option_value" ]; then
        echo "$default_value"
    else
        echo "$option_value"
    fi
}

launch() {
    local key=$(get_tmux_option $key_option $default_key)
    tmux bind-key "$key" display-popup -EE "$default_snips_dir"
}

main() {
    launch
}

main
