# JQ Basics

## Compact output

```bash
jq -c '.'
```

## Select Multiple fields

```bash
jq '{name: .fullname, age}'
```

## Filter based on conditions

```bash
jq '.users[] | select(.age > 25 and .age < 40)'
```

## Rename fields

```bash
jq '{username: .name, userage: .age}'
```

## Modify field values

```bash
jq '.users[] | .age = .age + 1'
```

## Delete a field

```bash
jq '.users[] | del(.password)'
```

## Array length

```bash
jq '.users | length'
```

## Map array values

```bash
jq '.users | map(.name)'
```

## Create json with variables

Usefull for inserting special characters into a json

```bash
jq -n --arg css 'complex-string' '{custom:$css}'
```
