#!/usr/bin/env python3
import re
import sys
from pathlib import Path

ROOTS = [
    Path('templates'),
    Path('public/assets/js'),
    Path('public/assets/css'),
]

CLASS_ATTR_RE = re.compile(r'class\s*=\s*(["\'])(.*?)\1', re.S)
CLASSNAME_RE = re.compile(r'className\s*=\s*(["\'])(.*?)\1', re.S)

# Allow letters, numbers, underscore, hyphen. Must not start with '-'.
TOKEN_RE = re.compile(r'^[A-Za-z_][A-Za-z0-9_-]*$')

PHP_TAG_RE = re.compile(r'<\?(?:php|=)[\s\S]*?\?>')
JS_EXPR_RE = re.compile(r'\$\{[\s\S]*?\}')
PHP_CONCAT_RE = re.compile(r"(['\"])\s*\.\s*|\.\s*(['\"])")


def iter_files():
    for root in ROOTS:
        if not root.exists():
            continue
        for path in root.rglob('*'):
            if path.is_file() and path.suffix in {'.php', '.js', '.css'}:
                yield path


def normalize_class_string(raw: str) -> str:
    cleaned = PHP_TAG_RE.sub(' ', raw)
    cleaned = JS_EXPR_RE.sub(' ', cleaned)
    return cleaned


def should_skip_raw(raw: str) -> bool:
    # Skip PHP string concatenations inside class attributes.
    if PHP_CONCAT_RE.search(raw):
        return True
    return False


def find_class_tokens(text: str):
    for regex in (CLASS_ATTR_RE, CLASSNAME_RE):
        for match in regex.finditer(text):
            raw = match.group(2)
            if should_skip_raw(raw):
                continue
            cleaned = normalize_class_string(raw)
            tokens = re.split(r'\s+', cleaned.strip()) if cleaned.strip() else []
            yield raw, tokens


def is_bad_token(token: str) -> bool:
    if token == '':
        return False
    if token.startswith('-'):
        return True
    if not TOKEN_RE.match(token):
        return True
    return False


def main():
    issues = []
    for path in iter_files():
        try:
            text = path.read_text(errors='ignore')
        except Exception:
            continue
        for raw, tokens in find_class_tokens(text):
            bad = [t for t in tokens if is_bad_token(t)]
            if bad:
                issues.append((str(path), raw, bad))
    if issues:
        print('Invalid class tokens found:')
        for path, raw, bad in issues:
            print(f'- {path}: {bad} in "{raw}"')
        return 1
    print('Class token check passed.')
    return 0


if __name__ == '__main__':
    sys.exit(main())
