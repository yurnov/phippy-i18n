#!/usr/bin/env python3
"""Turn books/<slug>/<lang>.md into the JSON that tools/book.typ typesets.

Standard library only, on purpose: a contributor should be able to check their
own page before opening a pull request without installing anything.

    python3 tools/build_book.py childrens-guide-to-kubernetes uk

The markdown dialect is deliberately small. Above the first `## p` heading is a
YAML front-matter block and then free notes for humans, both of which the book
ignores. From there on:

    ## p12 — anything after the page number is a note to reviewers
    ### a level-3 heading is a note page's title
    - a list item is a bullet, indented two spaces for a sub-bullet
    > a block quote is fine print, used on the credits page
    anything else is a paragraph; single newlines inside it reflow

Inline, `*text*` is the only markup, and it means italic.
"""
from __future__ import annotations

import json
import pathlib
import re
import sys

ROOT = pathlib.Path(__file__).resolve().parent.parent
BOOKS = ROOT / "books"
BUILD = ROOT / "build"

PAGE_RE = re.compile(r"^##\s+p(\d+)\b")
EM_RE = re.compile(r"\*([^*]+)\*")


def die(msg: str) -> None:
    raise SystemExit(f"build_book: {msg}")


def parse_front_matter(text: str) -> tuple[dict, str]:
    """The `---` block at the top: `key: value`, or `key:` then `  - item` lines."""
    if not text.startswith("---\n"):
        die("file does not start with a --- front-matter block")
    end = text.index("\n---\n", 3)
    body = text[end + 5 :]

    meta: dict[str, object] = {}
    key: str | None = None
    for raw in text[4:end].split("\n"):
        if not raw.strip():
            continue
        if raw.startswith(("  - ", "- ")) and key:
            meta.setdefault(key, [])
            if not isinstance(meta[key], list):
                die(f"{key!r} has both a value and list items")
            meta[key].append(raw.split("- ", 1)[1].strip())  # type: ignore[union-attr]
            continue
        if ":" not in raw:
            die(f"cannot parse front-matter line {raw!r}")
        key, _, value = raw.partition(":")
        key, value = key.strip(), value.strip()
        meta[key] = value if value else []
    return meta, body


def runs(text: str) -> list[dict]:
    """Split a line into italic and upright runs."""
    out: list[dict] = []
    pos = 0
    for m in EM_RE.finditer(text):
        if m.start() > pos:
            out.append({"text": text[pos : m.start()], "em": False})
        out.append({"text": m.group(1), "em": True})
        pos = m.end()
    if pos < len(text):
        out.append({"text": text[pos:], "em": False})
    return out or [{"text": "", "em": False}]


def parse_page(lines: list[str]) -> dict:
    """One page's body into a title and an ordered list of blocks.

    Order matters: the credits page interleaves paragraphs and lists, and
    rendering all the paragraphs before all the lists would scramble it.
    """
    page: dict = {"title": None, "blocks": []}
    para: list[str] = []
    quote: list[str] = []
    items: list[dict] | None = None

    def flush_para() -> None:
        if para:
            page["blocks"].append({"type": "para", "runs": runs(" ".join(para))})
            para.clear()

    def flush_quote() -> None:
        if quote:
            paras = [p for p in " \n".join(quote).split("\n \n") if p.strip()]
            page["blocks"].append(
                {"type": "fine", "paras": [runs(p.strip()) for p in paras]}
            )
            quote.clear()

    def flush_list() -> None:
        nonlocal items
        if items:
            page["blocks"].append({"type": "lines", "items": items})
        items = None

    for raw in lines:
        line = raw.rstrip()
        stripped = line.strip()

        if not stripped:
            flush_para()
            flush_quote()
            continue

        if stripped.startswith(">"):
            flush_para()
            flush_list()
            quote.append(stripped[1:].strip())
            continue
        flush_quote()

        if stripped.startswith("### "):
            flush_para()
            flush_list()
            page["title"] = runs(stripped[4:].strip())
            continue

        if stripped.startswith("- "):
            flush_para()
            if items is None:
                items = []
            item_runs = runs(stripped[2:].strip())
            if line.startswith("  ") and items:
                items[-1]["children"].append(item_runs)
            else:
                items.append({"runs": item_runs, "children": []})
            continue

        flush_list()
        para.append(stripped)

    flush_para()
    flush_quote()
    flush_list()
    return page


def parse_book(path: pathlib.Path) -> tuple[dict, dict[int, dict]]:
    meta, body = parse_front_matter(path.read_text(encoding="utf-8"))

    chunks: dict[int, list[str]] = {}
    current: list[str] | None = None
    for line in body.split("\n"):
        m = PAGE_RE.match(line)
        if m:
            n = int(m.group(1))
            if n in chunks:
                die(f"{path.name}: page p{n} appears twice")
            current = chunks.setdefault(n, [])
            continue
        if current is not None:
            current.append(line)
    if not chunks:
        die(f"{path.name}: no '## pN' page headings found")
    return meta, {n: parse_page(ls) for n, ls in chunks.items()}


def build(slug: str, lang: str) -> pathlib.Path:
    src = BOOKS / slug
    book = json.loads((src / "book.json").read_text(encoding="utf-8"))
    layout = json.loads((src / "art" / "layout.json").read_text(encoding="utf-8"))
    meta, parsed = parse_book(src / f"{lang}.md")

    if meta.get("lang") != lang:
        die(f"{lang}.md declares lang: {meta.get('lang')!r}")

    pages = []
    for spec in book["pages"]:
        n, kind = spec["n"], spec["kind"]
        if n not in parsed:
            die(f"{lang}.md is missing page p{n} ({kind})")
        page = dict(spec)
        page.update(parsed.pop(n))

        if kind == "note":
            if not page["title"]:
                die(f"{lang}.md p{n} is a note page but has no '### title'")
            if not any(b["type"] == "lines" for b in page["blocks"]):
                die(f"{lang}.md p{n} is a note page but has no bullets")
        if kind == "note":
            page["diagram"] = layout["diagrams"][str(n)]
        if spec.get("art"):
            art = src / "art" / spec["art"]
            if not art.exists():
                die(f"missing artwork {art.relative_to(ROOT)} — run tools/extract_art.py")
            page["art"] = str(art.relative_to(ROOT))
        pages.append(page)

    if parsed:
        die(f"{lang}.md has pages not in book.json: {sorted(parsed)}")

    out = {
        "slug": slug,
        "lang": lang,
        "language": meta.get("language", lang),
        "title": meta.get("title", book["title_en"]),
        "status": meta.get("status", "draft"),
        "translators": meta.get("translators") or [],
        "reviewers": meta.get("reviewers") or [],
        "page": book["page"],
        "layout": layout,
        "pages": pages,
    }
    BUILD.mkdir(exist_ok=True)
    dest = BUILD / f"{slug}-{lang}.json"
    dest.write_text(json.dumps(out, indent=1, ensure_ascii=False) + "\n", encoding="utf-8")
    return dest


def main(argv: list[str]) -> int:
    if len(argv) != 2:
        print(__doc__.strip().split("\n\n")[0])
        print("\nusage: build_book.py <book-slug> <lang>")
        return 2
    dest = build(argv[0], argv[1])
    data = json.loads(dest.read_text(encoding="utf-8"))
    print(f"{dest.relative_to(ROOT)}  {len(data['pages'])} pages  {dest.stat().st_size} bytes")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1:]))
