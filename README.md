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

The repo is mounted read-only into the Adminer container, and `adminer.css` is symlinked into the web root, so edits are visible after a browser reload, with no rebuild or restart.

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
