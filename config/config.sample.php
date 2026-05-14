<?php
/**
 * Legacy compatibility sample.
 *
 * The active configuration contract is:
 * - copy .env.example to .env
 * - keep .env uncommitted
 * - keep config/config.php committed
 * - let config/config.php normalize environment values into application arrays
 */

declare(strict_types=1);

return require __DIR__ . '/config.php';

