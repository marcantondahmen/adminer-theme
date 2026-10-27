# CLAUDE.md

## Project

A custom CSS theme for [Adminer](https://www.adminer.org/), the PHP database management tool. The whole theme lives in `adminer.css` in the repo root. Docker is only the dev environment for previewing it.

## Commands

```sh
./dev.sh   # downloads seed if missing, runs docker compose up (foreground) → http://localhost:8000; Ctrl-C/exit runs docker compose down -v
```

Login: System `PostgreSQL`, Server `db`, User `postgres`, Password `postgres`, Database `northwind`.

## Structure

- `adminer.css`: the theme. The `adminer` service mounts the repo root read-only at `/theme` (outside the web root) and its `command` symlinks `/var/www/html/adminer.css` to `/theme/adminer.css`. Adminer loads it automatically, and edits show on browser reload with no rebuild. A directory mount is used on purpose: a single-file bind mount goes stale when an editor saves atomically (write new file + rename), and Adminer then fails with `file_get_contents(adminer.css): Failed to open stream`.
- `docker-compose.yml`: `db` (`postgres:latest`) and `adminer` (`adminer:latest`) services.
- `seed/`: downloaded seed SQL, mounted to `/docker-entrypoint-initdb.d`. Postgres runs it only when the data dir is empty. There is no named volume, so every `./dev.sh` run starts with a freshly seeded DB.
- `dev.sh`: the only entry point. Seeds via curl, cleans up through an `EXIT`/`INT`/`TERM` trap.

## Notes

- Keep `ADMINER_DESIGN` unset in compose, or the image's entrypoint overwrites `adminer.css` with a bundled design.
- The `adminer` service overrides `command` (not the entrypoint) and ends with the image's default CMD, `php -S [::]:8080 -t /var/www/html`. Keep the two in sync if the upstream image changes.
- Style against Adminer's own markup and classes (e.g. `#menu`, `#content`, `#breadcrumb`, `.links`, `table.checkable`). Check the rendered HTML at http://localhost:8000 rather than guessing selectors.
