#!/usr/bin/env bash
# Build the translated PDFs into build/.
#
#   tools/build.sh                                    every translation
#   tools/build.sh childrens-guide-to-kubernetes      one book's translations
#   tools/build.sh childrens-guide-to-kubernetes en   one named edition
#
# Naming a language builds it whatever it is. Left to itself the script skips
# each book's `source` language, because that one is the translation input, not
# an edition to publish: an English PDF from here would only be a worse copy of
# the book CNCF already ships. Build it by name when you want to check the
# template against the original.
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
import json
b = json.load(open('books/$slug/book.json'))
print('\n'.join(l for l in b['languages'] if l != b.get('source')))")
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
