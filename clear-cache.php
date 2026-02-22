<?php
declare(strict_types=1);

?><!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Clear Cache</title>
    <style>
        body { font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif; margin: 2rem; }
        .status { margin-top: 1rem; padding: 0.75rem 1rem; background: #f3f4f6; border-radius: 0.5rem; }
        .success { background: #ecfdf3; color: #065f46; }
        .error { background: #fef2f2; color: #991b1b; }
        button { padding: 0.5rem 1rem; font-size: 1rem; }
    </style>
</head>
<body>
    <h1>Clear Cache</h1>
    <p>This will unregister the service worker and delete Cache Storage entries for this site.</p>
    <button id="clear-cache-btn" type="button">Clear Cache</button>
    <div id="status" class="status">Ready.</div>

    <script>
        const statusEl = document.getElementById('status');
        const button = document.getElementById('clear-cache-btn');

        function setStatus(message, kind) {
            statusEl.textContent = message;
            statusEl.className = 'status' + (kind ? ' ' + kind : '');
        }

        async function clearCache() {
            try {
                setStatus('Clearing caches...', '');

                if ('serviceWorker' in navigator) {
                    const registrations = await navigator.serviceWorker.getRegistrations();
                    await Promise.all(registrations.map((reg) => reg.unregister()));
                }

                if ('caches' in window) {
                    const cacheNames = await caches.keys();
                    await Promise.all(cacheNames.map((name) => caches.delete(name)));
                }

                setStatus('Cache cleared. Reloading...', 'success');
                setTimeout(() => window.location.href = '/', 800);
            } catch (err) {
                setStatus('Failed to clear cache. Check console for details.', 'error');
                console.error(err);
            }
        }

        button.addEventListener('click', clearCache);
    </script>
</body>
</html>
