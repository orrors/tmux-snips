# JQ Basics

## Compact output

```bash
jq -c '.' file.json
```

## Select a field

```bash
jq '.name' file.json
```

## Select Multiple fields

```bash
jq '{name: .name, age: .age}' file.json
```

## Filter based on conditions

```bash
jq '.users[] | select(.age > 25)' file.json
```

## Rename fields

```bash
jq '{username: .name, userage: .age}' file.json
```

## Modify field values

```bash
jq '.age = .age + 1' file.json
```

## Delete a field

```bash
jq 'del(.password)' file.json
```

## array length

```bash
jq '.users | length' file.json
```

## Map array values

```bash
jq '.users | map(.name)' file.json
```
