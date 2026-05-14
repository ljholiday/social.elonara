<?php
declare(strict_types=1);

return [
    'environment' => social_string_config('APP_ENV', 'production'),

    'app' => [
        'name' => social_string_config('APP_NAME', 'Elonara Social'),
        'domain' => social_string_config('APP_DOMAIN', 'social.elonara.com'),
        'url' => rtrim(social_string_config('APP_URL', 'https://social.elonara.com'), '/'),
        'asset_url' => social_string_config('ASSET_URL', '/assets'),
        'support_email' => social_string_config('APP_SUPPORT_EMAIL', 'support@social.elonara.com'),
        'noreply_email' => social_string_config('APP_NOREPLY_EMAIL', 'no-reply@social.elonara.com'),
        'debug' => social_bool_config('APP_DEBUG', false),
    ],

    'database' => [
        'host' => social_string_config('DB_HOST', '127.0.0.1'),
        'port' => social_int_config('DB_PORT', 3306),
        'name' => social_string_config('DB_DATABASE', social_string_config('DB_NAME', '')),
        'username' => social_string_config('DB_USERNAME', social_string_config('DB_USER', '')),
        'password' => social_string_config('DB_PASSWORD', ''),
        'charset' => social_string_config('DB_CHARSET', 'utf8mb4'),
        'options' => [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ],
    ],

    'mail' => [
        'transport' => social_string_config('MAIL_DRIVER', 'smtp'),
        'host' => social_string_config('MAIL_HOST', ''),
        'port' => social_int_config('MAIL_PORT', 25),
        'auth' => social_bool_config('MAIL_AUTH', false),
        'username' => social_string_config('MAIL_USERNAME', ''),
        'password' => social_string_config('MAIL_PASSWORD', ''),
        'encryption' => social_string_config('MAIL_ENCRYPTION', ''),
        'timeout' => social_int_config('MAIL_TIMEOUT', 30),
        'sendmail_path' => social_string_config('MAIL_SENDMAIL_PATH', '/usr/sbin/sendmail -bs'),
        'from_address' => social_string_config('MAIL_FROM_ADDRESS', ''),
        'from_name' => social_string_config('MAIL_FROM_NAME', ''),
        'reply_to_address' => social_string_config('MAIL_REPLY_TO_ADDRESS', ''),
        'reply_to_name' => social_string_config('MAIL_REPLY_TO_NAME', ''),
        'debug' => social_int_config('MAIL_DEBUG', 0),
    ],

    'security' => [
        'salts' => [
            'auth' => '',
            'nonce' => '',
            'session' => '',
        ],
    ],

    'users' => [
        'username_min_length' => 2,
        'username_max_length' => 30,
    ],

    'images' => [
        'sizes' => [
            'profile' => [
                'original' => ['width' => 400, 'height' => 400],
                'medium'   => ['width' => 200, 'height' => 200],
                'small'    => ['width' => 100, 'height' => 100],
                'thumb'    => ['width' => 48, 'height' => 48],
            ],
            'cover' => [
                'original' => ['width' => 1200, 'height' => 400],
                'tablet'   => ['width' => 768, 'height' => 256],
                'mobile'   => ['width' => 640, 'height' => 213],
            ],
            'post' => [
                'original' => ['width' => 800, 'height' => 600],
                'mobile'   => ['width' => 640, 'height' => 480],
                'thumb'    => ['width' => 320, 'height' => 240],
            ],
            'featured' => [
                'original' => ['width' => 1200, 'height' => 630],
                'mobile'   => ['width' => 640, 'height' => 336],
            ],
        ],
        'quality' => [
            'jpeg' => 90,
            'png' => 8,
            'webp' => 85,
        ],
        'max_size' => 10 * 1024 * 1024,
        'allowed_types' => [
            'image/jpeg',
            'image/png',
            'image/gif',
            'image/webp',
        ],
        'upload_base' => '/uploads',
        'generate_webp' => true,
    ],

    'bluesky' => [
        'app_passwords' => [
            'enabled' => true,
            'freeze_existing_integrations' => true,
        ],
        'oauth' => [
            'enabled' => social_bool_config('BLUESKY_OAUTH_ENABLED', false),
            'client_id' => social_string_config('BLUESKY_CLIENT_ID', ''),
            'client_secret' => social_string_config('BLUESKY_CLIENT_SECRET', ''),
            'client_private_key' => social_string_config('BLUESKY_CLIENT_PRIVATE_KEY', ''),
            'client_key_id' => social_string_config('BLUESKY_CLIENT_KEY_ID', ''),
            'token_endpoint_auth_method' => social_string_config('BLUESKY_TOKEN_AUTH_METHOD', 'private_key_jwt'),
            'metadata_url' => social_string_config('BLUESKY_METADATA_URL', 'https://bsky.social/.well-known/oauth-authorization-server'),
            'client_metadata_url' => social_string_config('BLUESKY_CLIENT_METADATA_URL', 'https://social.elonara.com/oauth/oauth-client-metadata.json'),
            'redirect_uri' => social_string_config('BLUESKY_REDIRECT_URI', 'https://social.elonara.com/auth/bluesky/callback'),
            'scopes' => social_string_config('BLUESKY_SCOPES', 'repo:app.bsky.feed.post blob:*/* rpc:com.atproto.repo.createRecord?aud=did:web:bsky.social'),
            'force_for_invites' => social_bool_config('BLUESKY_FORCE_FOR_INVITES', true),
            'allow_legacy_fallback' => social_bool_config('BLUESKY_ALLOW_LEGACY', true),
        ],
        'encryption' => [
            'key' => social_string_config('BLUESKY_TOKEN_KEY', ''),
            'cipher' => 'aes-256-gcm',
        ],
    ],
];

function social_string_config(string $key, string $default = ''): string
{
    $value = $_SERVER[$key] ?? $_ENV[$key] ?? $default;
    return trim((string) $value);
}

function social_int_config(string $key, int $default): int
{
    $value = $_SERVER[$key] ?? $_ENV[$key] ?? $default;
    return max(0, (int) $value);
}

function social_bool_config(string $key, bool $default): bool
{
    $value = $_SERVER[$key] ?? $_ENV[$key] ?? $default;
    if (is_bool($value)) {
        return $value;
    }

    return filter_var($value, FILTER_VALIDATE_BOOL);
}
