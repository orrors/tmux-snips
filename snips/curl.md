# Curl

## Headers

```bash
curl -H "Authorization: Basic YWJjOmRlZg==" <url>
```

## Headers from file

From a ".token" file for example

```bash
curl -H @.token <url>
```

## Follow redirects

```bash
curl -L <url>
```

## Dump response headers

```bash
curl -D- <url>
```

## Post request with data

Implies `-X POST` and `-H 'Content-Type: application/x-www-form-urlencoded'`

```bash
curl -d 'var=value' <url>
```

## Post request with json

Using `--json` automatically implies `-X POST`

```bash
curl <url> --json '{"sample":"data"}'
```

## Don't modify the path

```bash
curl --path-as-is 'http://example.com/../../../etc/passwd'
```
