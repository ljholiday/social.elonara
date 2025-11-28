#!/usr/bin/env bash
# Simple health monitor for cron or external schedulers.
# Fails (non-zero exit) if /health is unreachable or reports degraded status.
set -euo pipefail

URL="${HEALTH_URL:-https://social.elonara.com/health}"
TIMEOUT="${HEALTH_TIMEOUT:-10}"

if ! command -v curl >/dev/null 2>&1; then
    echo "ERROR: curl is required" >&2
    exit 3
fi

response="$(
    curl --fail --silent --show-error --max-time "${TIMEOUT}" "${URL}" \
        || { echo "ERROR: request to ${URL} failed" >&2; exit 2; }
)"

# Parse and validate the JSON response using PHP (guaranteed available on host).
php -r '
    $body = stream_get_contents(STDIN);
    $data = json_decode($body, true);
    if (!is_array($data)) {
        fwrite(STDERR, "ERROR: invalid JSON from /health\n");
        exit(3);
    }
    $status = $data["status"] ?? "";
    $checks = $data["checks"] ?? [];
    $failedChecks = [];
    foreach ($checks as $name => $value) {
        if ($value !== "ok") {
            $failedChecks[] = $name;
        }
    }
    if ($status !== "ok" || $failedChecks) {
        $failedList = $failedChecks ? implode(",", $failedChecks) : "none";
        $msg = sprintf(
            "ERROR: health=%s failed_checks=%s environment=%s",
            $status ?: "missing",
            $failedList,
            $data["environment"] ?? "unknown"
        );
        fwrite(STDERR, $msg . PHP_EOL);
        exit(1);
    }
    printf(
        "OK: %s (env=%s)\n",
        $data["status"],
        $data["environment"] ?? "unknown"
    );
' <<< "${response}"
