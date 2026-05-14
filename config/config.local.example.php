<?php
/**
 * Elonara Social - Local Development Configuration Example
 *
 * Legacy local reference. Prefer copying .env.example to .env and using the
 * committed config/config.php normalizer.
 *
 * Mailpit defaults:
 * - SMTP: 127.0.0.1:1025
 * - Web UI: http://127.0.0.1:8025
 */

declare(strict_types=1);

return [
    'environment' => 'local',

    'app' => [
        'name' => 'Elonara Social',
        'domain' => 'social.elonara.local',
        'url' => 'https://social.elonara.local',
        'asset_url' => '/assets',
        'support_email' => 'support@social.elonara.local',
        'noreply_email' => 'no-reply@social.elonara.local',
        'debug' => true,
    ],

    'database' => [
        'host' => '127.0.0.1',
        'port' => 3306,
        'name' => 'social_elonara',
        'username' => 'social_elonara',
        'password' => 'change_me',
        'charset' => 'utf8mb4',
        'options' => [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
            PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
            PDO::ATTR_EMULATE_PREPARES => false,
        ],
    ],

    'mail' => [
        'transport' => 'smtp',
        'host' => '127.0.0.1',
        'port' => 1025,
        'auth' => false,
        'username' => '',
        'password' => '',
        'encryption' => '',
        'timeout' => 30,
        'sendmail_path' => '/usr/sbin/sendmail -bs',
        'from_address' => 'no-reply@social.elonara.local',
        'from_name' => 'Elonara Social',
        'reply_to_address' => 'support@social.elonara.local',
        'reply_to_name' => 'Elonara Social Support',
        'debug' => 0,
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
            'enabled' => filter_var(getenv('BLUESKY_OAUTH_ENABLED') ?: false, FILTER_VALIDATE_BOOLEAN),
            'client_id' => getenv('BLUESKY_CLIENT_ID') ?: '',
            'client_secret' => getenv('BLUESKY_CLIENT_SECRET') ?: '',
            'client_private_key' => getenv('BLUESKY_CLIENT_PRIVATE_KEY') ?: '',
            'client_key_id' => getenv('BLUESKY_CLIENT_KEY_ID') ?: '',
            'token_endpoint_auth_method' => getenv('BLUESKY_TOKEN_AUTH_METHOD') ?: 'private_key_jwt',
            'metadata_url' => getenv('BLUESKY_METADATA_URL') ?: 'https://bsky.social/.well-known/oauth-authorization-server',
            'client_metadata_url' => getenv('BLUESKY_CLIENT_METADATA_URL') ?: 'https://social.elonara.local/oauth/oauth-client-metadata.json',
            'redirect_uri' => getenv('BLUESKY_REDIRECT_URI') ?: 'https://social.elonara.local/auth/bluesky/callback',
            'scopes' => getenv('BLUESKY_SCOPES')
                ?: 'repo:app.bsky.feed.post blob:*/* rpc:com.atproto.repo.createRecord?aud=did:web:bsky.social',
            'force_for_invites' => filter_var(getenv('BLUESKY_FORCE_FOR_INVITES') ?: true, FILTER_VALIDATE_BOOLEAN),
            'allow_legacy_fallback' => filter_var(getenv('BLUESKY_ALLOW_LEGACY') ?: true, FILTER_VALIDATE_BOOLEAN),
        ],
        'encryption' => [
            'key' => getenv('BLUESKY_TOKEN_KEY') ?: '',
            'cipher' => 'aes-256-gcm',
        ],
    ],
];
