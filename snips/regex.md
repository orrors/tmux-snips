# VIM Regex

## Basic Atoms

 | Pattern  | Meaning                                      |
 | -------- | --------                                     |
 | `.`      | Any character except newline                 |
 | `\a`     | Alphabetic character                         |
 | `\d`     | Digit                                        |
 | `\x`     | Hex digit                                    |
 | `\o`     | Octal digit                                  |
 | `\w`     | Word character (letters, digits, underscore) |
 | `\W`     | Non-word character                           |
 | `\s`     | Whitespace                                   |
 | `\S`     | Non-whitespace                               |


## Character Classes

 | Pattern  | Meaning                          |
 | -------- | --------                         |
 | `[abc]`  | Match a, b, or c                 |
 | `[^abc]` | Not a, b, or c                   |
 | `[a-z]`  | Range                            |
 | `\_s`    | Whitespace including newline     |
 | `\_w`    | Word character including newline |


## Quantifiers

 | Pattern  | Meaning          |
 | -------- | --------         |
 | `*`      | 0 or more        |
 | `\+`     | 1 or more        |
 | `\=`     | 0 or 1           |
 | `\{n}`   | Exactly n        |
 | `\{n,m}` | Between n and m  |
 | `\{-}`   | Non-greedy match |

Example:

```vim
/\w\+
```
Match one or more word characters.

## Anchors

 | Pattern  | Meaning       |
 | -------- | --------      |
 | `^`      | Start of line |
 | `$`      | End of line   |
 | `\<`     | Start of word |
 | `\>`     | End of word   |


## Groups and Alternation

 | Pattern     | Meaning  |
 | --------    | -------- |
 | `\( ... \)` | Group    |
 | `\|`        | OR       |

Example:

```vim
/\(cat\|dog\)
```
Matches "cat" or "dog".


## Lookaheads and Lookbehinds

### Lookahead (match ahead without consuming)

| Pattern | Meaning |
|--------|--------|
| `\@=` | Positive lookahead |
| `\@!` | Negative lookahead |

Example:

```vim
/foo\@=bar
```
Match "foo" only if followed by "bar".

### Lookbehind (match behind without consuming)

| Pattern | Meaning |
|--------|--------|
| `\@<=` | Positive lookbehind |
| `\@<!` | Negative lookbehind |

Example:

```vim
/\@<=foo
```
Match "foo" only if preceded by something (define before it).

More practical:

```vim
/\d\+\@=px
```
Match numbers only if followed by "px".

```vim
/\$\@<=\d\+
```
Match numbers only if preceded by "$".


## Magic Modes

Vim regex changes behavior depending on "magic" settings.

| Mode | Description |
|------|------------|
| `\v` | Very magic (recommended) |
| `\m` | Magic (default) |
| `\M` | Nomagic |
| `\V` | Very nomagic |

Example:

```vim
/\v\w+
```
Cleaner syntax (no need to escape `+`).


## Substitution Tricks

Basic substitution:

```vim
:%s/pattern/replacement/g
```

Capture groups:

```vim
:%s/\(\w\+\) \(\w\+\)/\2 \1/g
```
Swap two words.

Use very magic:

```vim
:%s/\v(\w+) (\w+)/\2 \1/g
```

## Practical Examples

### Match email-like strings

```vim
/\v\w+@\w+\.\w+
```

### Remove trailing whitespace

```vim
:%s/\s\+$//g
```

### Find lines NOT containing a word

```vim
:v/pattern/d
```

### Match HTML tags

```vim
/\v<\w+>.*<\/\w+>
```

### Non-greedy match example

```vim
/\v<.*?>
```

## Tips

- Use `\v` (very magic) for simpler patterns
- Use `\zs` and `\ze` to define match boundaries

Example:

```vim
/\vfoo\zsbar
```
Only "bar" is highlighted.


