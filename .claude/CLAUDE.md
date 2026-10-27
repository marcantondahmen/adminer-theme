# CLAUDE.md

## Project

A custom CSS theme for [Adminer](https://www.adminer.org/), the PHP database management tool. The whole theme lives in `adminer.css` in the repo root. Docker is only the dev environment for previewing it.

## Commands

```sh
./dev.sh   # downloads seed if missing, runs docker compose up (foreground) → http://localhost:8000; Ctrl-C/exit runs docker compose down -v
```

Login: System `PostgreSQL`, Server `db`, User `postgres`, Password `postgres`, Database `northwind`.

## Structure

- `adminer.css`: the theme, the only file in the repo root that gets mounted into a container. It is bind-mounted read-only to `/var/www/html/adminer.css` in the `adminer` service, and Adminer loads it automatically. Edits show on browser reload with no rebuild.
- `docker-compose.yml`: `db` (`postgres:latest`) and `adminer` (`adminer:latest`) services.
- `seed/`: downloaded seed SQL, mounted to `/docker-entrypoint-initdb.d`. Postgres runs it only when the data dir is empty. There is no named volume, so every `./dev.sh` run starts with a freshly seeded DB.
- `dev.sh`: the only entry point. Seeds via curl, cleans up through an `EXIT`/`INT`/`TERM` trap.

## Notes

- Keep `ADMINER_DESIGN` unset in compose, or the image's entrypoint overwrites `adminer.css` with a bundled design.
- On Docker Desktop for macOS, atomic-save editors can break the single-file bind mount. Run `docker compose restart adminer` (in a second terminal) if CSS changes stop showing up.
- Style against Adminer's own markup and classes (e.g. `#menu`, `#content`, `#breadcrumb`, `.links`, `table.checkable`). Check the rendered HTML at http://localhost:8000 rather than guessing selectors.
