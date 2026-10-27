# Adminer Theme

A minimal dark theme for Adminer

## Usage

Copy `adminer.css` into the same directory as `adminer.php` (or `index.php`) on your server. Adminer picks it up automatically.

With the official Docker image, mount it instead:

```yaml
volumes:
  - ./adminer.css:/var/www/html/adminer.css:ro
```

## Development

Requirements: Docker (with Compose) and curl.

```sh
./dev.sh
```

This downloads the Northwind seed to `seed/northwind.sql` on first run, then starts Postgres and Adminer in the foreground. Ctrl-C stops everything and removes containers, networks and volumes, so every run starts with a freshly seeded database.

Open http://localhost:8000/?pgsql=db&username=postgres and log in with:

| Field    | Value      |
| -------- | ---------- |
| System   | PostgreSQL |
| Server   | db         |
| Username | postgres   |
| Password | postgres   |
| Database | northwind  |

`adminer.css` is bind-mounted into the Adminer container, so edits are visible after a browser reload, with no rebuild or restart.

> If edits stop showing up, your editor's atomic/safe-write save may have broken the single-file bind mount (a known Docker Desktop for macOS issue). Run `docker compose restart adminer` (in a second terminal) or turn off atomic saving in the editor.

### Project structure

```
.
├── adminer.css          # the theme
├── dev.sh               # seed download + compose up/down
├── docker-compose.yml   # postgres + adminer services
└── seed/                # downloaded seed SQL (gitignored)
```

The sample database is [Northwind for PostgreSQL](https://github.com/pthom/northwind_psql).

## License

[MIT](LICENSE)
