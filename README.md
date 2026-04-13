# tmux-snips

Code and cli snips at your fingertips

## Requirements

- fzf
- rg
- vim/nvim

Optional:

- bat

To use the clipboard set this on your `.tmux.conf`:

```tmux
set -s set-clipboard on
```

## Configurable options

Keybinding:
```tmux
set -g @snips-key 'C-q'
```

Add custom snippets directory:
```tmux
set -g @snips-dir '<path>'
```

Configure popup:

```tmux
set -g @snips-popup-flags '-b rounded -w60% -h60%'
```
