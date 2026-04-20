# Postgres cli tools (psql, pg_dump, pg_restore)

## Dump database to stdout (include drop commands for overwrite)

```bash
pg_dump -cOx -Fc <url>
```

## Dump database to stdout (data only)

```bash
pg_dump -aOx -Fc <url>
```

## Dump tables to stdout (data only)

```bash
pg_dump -aOx -Fc -t <pattern> -t <pattern> <url>
```

## Restore db from stdin

```bash
pg_restore -Ox -Fc -d <target-db>
```
