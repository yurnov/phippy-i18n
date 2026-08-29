#!/usr/bin/env bash
# Build PDFs for every language of every book, into build/.
#
#   tools/build.sh                     everything
#   tools/build.sh childrens-guide-to-kubernetes      one book
#   tools/build.sh childrens-guide-to-kubernetes uk   one edition
#
# Needs python3 (standard library only) and typst on PATH.
set -euo pipefail

cd "$(dirname "$0")/.."

if ! command -v typst >/dev/null; then
    echo "typst not found on PATH — see https://github.com/typst/typst/releases" >&2
    exit 1
fi

books=("${1:-}")
if [ -z "${books[0]}" ]; then
    books=()
    for f in books/*/book.json; do books+=("$(basename "$(dirname "$f")")"); done
fi

mkdir -p build

for slug in "${books[@]}"; do
    langs=("${2:-}")
    if [ -z "${langs[0]}" ]; then
        mapfile -t langs < <(python3 -c "
import json,sys
print('\n'.join(json.load(open('books/$slug/book.json'))['languages']))")
    fi

    for lang in "${langs[@]}"; do
        out="build/$slug-$lang.pdf"
        python3 tools/build_book.py "$slug" "$lang"
        typst compile \
            --root . \
            --font-path fonts \
            --ignore-system-fonts \
            --input "book=/build/$slug-$lang.json" \
            tools/book.typ "$out"
        printf '%-52s %s\n' "$out" "$(du -h "$out" | cut -f1)"
    done
done
