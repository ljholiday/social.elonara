<?php
/**
 * Head Meta Tags Partial
 *
 * SEO and social media meta tags for inclusion in layout <head> sections.
 *
 * Required variables:
 * @var string $fullTitle - Full page title with app name
 * @var string $page_description - Optional page description
 * @var string $assetBase - Base path for assets
 * @var string|null $canonical_url - Optional absolute canonical URL override
 * @var string|null $robots_meta - Optional robots directive
 * @var array<int|string,mixed> $structured_data - Optional JSON-LD payload(s)
 */

declare(strict_types=1);

$appUrl = rtrim((string)app_config('app.url', 'http://localhost'), '/');
$requestUri = (string)($_SERVER['REQUEST_URI'] ?? '/');
$requestPath = (string)(parse_url($requestUri, PHP_URL_PATH) ?? '/');
$currentUrl = $appUrl . $requestUri;
$canonicalUrl = $canonical_url ?? ($appUrl . $requestPath);
$robotsMeta = trim((string)($robots_meta ?? ''));
$structuredData = $structured_data ?? [];
if ($structuredData !== [] && array_keys($structuredData) !== range(0, count($structuredData) - 1)) {
    $structuredData = [$structuredData];
}
?>
    <?php if ($page_description): ?>
    <meta name="description" content="<?= htmlspecialchars($page_description, ENT_QUOTES, 'UTF-8'); ?>">
    <?php endif; ?>
    <link rel="canonical" href="<?= htmlspecialchars($canonicalUrl, ENT_QUOTES, 'UTF-8'); ?>">
    <?php if ($robotsMeta !== ''): ?>
    <meta name="robots" content="<?= htmlspecialchars($robotsMeta, ENT_QUOTES, 'UTF-8'); ?>">
    <?php endif; ?>

    <!-- Open Graph / Social Media -->
    <meta property="og:type" content="website">
    <meta property="og:url" content="<?= htmlspecialchars($currentUrl, ENT_QUOTES, 'UTF-8'); ?>">
    <meta property="og:title" content="<?= htmlspecialchars($fullTitle, ENT_QUOTES, 'UTF-8'); ?>">
    <?php if ($page_description): ?>
    <meta property="og:description" content="<?= htmlspecialchars($page_description, ENT_QUOTES, 'UTF-8'); ?>">
    <?php endif; ?>
    <meta property="og:image" content="<?= htmlspecialchars($appUrl . $assetBase . '/icons/og-image.png', ENT_QUOTES, 'UTF-8'); ?>">
    <meta property="og:image:width" content="630">
    <meta property="og:image:height" content="630">

    <!-- Twitter Card -->
    <meta name="twitter:card" content="summary">
    <meta name="twitter:title" content="<?= htmlspecialchars($fullTitle, ENT_QUOTES, 'UTF-8'); ?>">
    <?php if ($page_description): ?>
    <meta name="twitter:description" content="<?= htmlspecialchars($page_description, ENT_QUOTES, 'UTF-8'); ?>">
    <?php endif; ?>
    <meta name="twitter:image" content="<?= htmlspecialchars($appUrl . $assetBase . '/icons/og-image.png', ENT_QUOTES, 'UTF-8'); ?>">
    <?php foreach ($structuredData as $jsonLd): ?>
        <?php if (is_array($jsonLd) && $jsonLd !== []): ?>
    <script type="application/ld+json"><?= json_encode($jsonLd, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE); ?></script>
        <?php endif; ?>
    <?php endforeach; ?>

    <!-- Google Analytics -->
    <?php
    $gaTrackingId = (string)app_config('analytics.google_tracking_id', '');
    if ($gaTrackingId !== ''):
    ?>
    <script async src="https://www.googletagmanager.com/gtag/js?id=<?= htmlspecialchars($gaTrackingId, ENT_QUOTES, 'UTF-8'); ?>"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());
      gtag('config', '<?= htmlspecialchars($gaTrackingId, ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8'); ?>');
    </script>
    <?php endif; ?>
