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

## Lookahead (match ahead without consuming)

| Pattern | Meaning |
|--------|--------|
| `\@=` | Positive lookahead |
| `\@!` | Negative lookahead |

Example:

```vim
/foo\@=bar
```
Match "foo" only if followed by "bar".

## Lookbehind (match behind without consuming)

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

## Match email-like strings

```vim
/\v\w+@\w+\.\w+
```
================================================================================================

# Other VIM stuff

## Substitution

Basic substitution:

```vim
:%s/pattern/replacement/g
```

## Substitution with capture groups:

```vim
:%s/\(\w\+\) \(\w\+\)/\2 \1/g
```
Swap two words.

Use very magic:

```vim
:%s/\v(\w+) (\w+)/\2 \1/g
```

## Remove trailing whitespace

```vim
:%s/\s\+$//g
```

## Delete lines with pattern

```vim
:g/pattern/d
```

Delete lines that don't match

```vim
:v/pattern/d
```

## Delete lines with pattern into buffer

This basically runs the normal command `"Add` on every match which appends to the 'a register.
Paste the copied items with `"ap`

```vim
:g/pattern/normal "Add
```

## Copy lines with pattern into buffer

```vim
:g/pattern/normal "Ayy
```

## Run macro on matching lines

```vim
:g/pattern/normal @q
```

## Run macro on all quickfix positions

```vim
:cdo normal @q
```
