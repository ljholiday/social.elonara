# Local Development

Use `social.elonara.local` for local development so cookies, OAuth redirects, and generated URLs match the rest of the local domain setup.

## Config

```bash
cp .env.example .env
```

Edit `.env` for your local database password. `.env` is intentionally ignored by git. `config/config.php` is committed and normalizes `.env` values into application config arrays.

## Database

Create the local database and password-authenticated user before running `./install.sh`:

```sql
CREATE DATABASE IF NOT EXISTS social_elonara
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

CREATE USER IF NOT EXISTS 'social_elonara'@'localhost'
  IDENTIFIED BY 'change_me';

ALTER USER 'social_elonara'@'localhost'
  IDENTIFIED BY 'change_me';

GRANT ALL PRIVILEGES ON social_elonara.* TO 'social_elonara'@'localhost';
FLUSH PRIVILEGES;
```

If `.env` uses a different password, use that password in both `CREATE USER` / `ALTER USER` statements.

On Debian/MariaDB, run it through an admin account, for example:

```bash
sudo mysql
```

Then verify:

```bash
mysql -usocial_elonara -p social_elonara -e "SELECT 1"
./install.sh
```

## Hostname

Add this if it is not already present:

```text
127.0.0.1 social.elonara.local
```

The local app URL should be HTTPS:

```text
https://social.elonara.local
```

Use the local wildcard mkcert certificate already used by the other `.local` vhosts, or create one that covers `social.elonara.local`.

## Mailpit

Mailpit should listen on:

```text
SMTP: 127.0.0.1:1025
UI:   http://127.0.0.1:8025
```

The local config example is already set to send through Mailpit without SMTP auth or encryption.
