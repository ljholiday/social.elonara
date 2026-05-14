<?php
/**
 * Legacy compatibility sample.
 *
 * For local development, copy .env.example to .env and set:
 * - APP_ENV=local
 * - APP_URL=https://social.elonara.local
 * - DB_DATABASE=social_elonara
 * - DB_USERNAME=social_elonara
 * - DB_PASSWORD=<local password>
 *
 * The committed config/config.php normalizes those values.
 */

declare(strict_types=1);

return require __DIR__ . '/config.php';

