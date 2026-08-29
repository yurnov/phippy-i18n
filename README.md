# phippy-i18n

Ukrainian (`uk`) and Polish (`pl`) translations of the CNCF **Phippy & Friends** books,
starting with *The Illustrated Children's Guide to Kubernetes*.

The text lives in Markdown. A GitHub Actions run turns it into a typeset PDF on every push,
using the original illustrations.

> **This is an unofficial community translation.** It is not published or endorsed by CNCF.
> The original characters, text and artwork are copyright The Linux Foundation on behalf of
> the Cloud Native Computing Foundation, licensed **CC-BY-4.0**, which is what makes this
> possible. See [`NOTICE.md`](NOTICE.md) for full attribution.

## Getting the PDFs

- **Released versions** — pushing a `v*` tag publishes the PDFs as a GitHub release. These are
  the ones anyone can download.
- **Latest build** — the `build-pdf` workflow attaches `phippy-i18n-pdfs` to every run.
  Downloading a run artifact requires being signed in to GitHub, so releases are the better
  link to hand to someone.

## Status

| Book | en | uk | pl | typeset |
|---|---|---|---|---|
| The Illustrated Children's Guide to Kubernetes | ✅ source | 🚧 draft, unreviewed | 🚧 draft, unreviewed | ✅ generated |

Neither translation has had a native-speaker review yet. That is the thing this repository
most needs — see [`CONTRIBUTING.md`](CONTRIBUTING.md).

This edition is deliberately a *simplified* one: real text, real illustrations, generated
reproducibly. A faithful reset of the original design — the original typeface, the hand-set
covers, a print-ready file — is separate work happening alongside it.

## Layout

```
books/childrens-guide-to-kubernetes/
    book.json    page manifest: which pages exist, what kind, which artwork,
                 and which languages are editions rather than the source
    en.md        source of truth — transcribed from the published CNCF PDF
    uk.md        Ukrainian
    pl.md        Polish
    art/         illustrations extracted from the published CC-BY-4.0 PDF
glossary/
    uk.md        Ukrainian term choices, with rationale
    pl.md        Polish term choices, with rationale
fonts/bitter/    Bitter (SIL OFL 1.1), the typeface the PDFs are set in
tools/
    extract_art.py  published PDF -> art/            (run rarely, output committed)
    build_book.py   <lang>.md + book.json -> JSON    (stdlib only)
    book.typ        the Typst template
    build.sh        build every translation into build/
    pdftext.py      stdlib PDF text extractor, used to check en.md against the original
```

Book-first rather than language-first: it keeps `en`/`uk`/`pl` side by side for review, while
the glossaries stay per-language and shared across books as more are added.

## How the PDF gets made

`en.md` was transcribed from
[the PDF CNCF publishes](https://www.cncf.io/wp-content/uploads/2020/08/The-Illustrated-Childrens-Guide-to-Kubernetes.pdf).
That file keeps its text in a live text layer, so its embedded images are the illustrations
*without* the English wording — which is what makes a translated edition possible at all
without redrawing anything.

Two pages needed more than a straight extract, and `tools/extract_art.py` handles both:

- **The technical-note pages** were flattened into one image each, English and all. Their
  background is a plain vertical watercolour wash, so the ink can be separated from it by
  difference matting and the diagram cut out on its own with a real alpha channel. The
  translated title and bullets are then set live, back in the positions the original used.
- **The front cover** has its title painted over open water. The artwork is cut above it and
  the water carried on as a gradient, so the translated title gets a clean surface.

Page geometry, the wash colours, the teal and blue, and where each diagram sits are all
measured out of the same PDF rather than guessed.

## Building locally

Needs `python3` (standard library only) and [`typst`](https://github.com/typst/typst/releases)
on `PATH`. Nothing else — the fonts and artwork are in the repo.

```sh
tools/build.sh                                    # every translation
tools/build.sh childrens-guide-to-kubernetes uk   # just one
```

`en` is the translation source, not an edition, so it is left out unless you name it —
`tools/build.sh childrens-guide-to-kubernetes en` builds it, which is the quickest way to
check the template against the book CNCF publishes.

Re-extracting the artwork is a separate, rare step, and the only one that needs third-party
packages:

```sh
docker run --rm -v "$PWD:/w" -w /w python:3.12-slim \
    bash -c "pip install -q pymupdf pillow numpy && python tools/extract_art.py"
```

## Translation rules

1. **`en.md` is the source of truth.** Translate from it, never from another translation.
2. Page numbering and the story / technical-note alternation must match the original exactly —
   the layout is fixed by the illustrations. The build fails if a page is missing.
3. Kubernetes API kinds (Pod, ReplicaSet, Service, Namespace, Volume) follow the conventions
   already established by the Kubernetes documentation localizations and the CNCF Cloud Native
   Glossary. **Do not invent literal translations.** Every decision is recorded in
   `glossary/<lang>.md`.
4. Story pages read as a children's book. Technical-note pages read as precise documentation.
   The original switches register between them and so should the translation.
5. Preserve the original credits and the `phippy.io` attribution in every derived file —
   this is a CC-BY licence condition, not a courtesy.

## Licence

Original work: CC-BY-4.0, The Linux Foundation on behalf of CNCF.
These translations: CC-BY-4.0, same terms. See [`LICENSE`](LICENSE) and [`NOTICE.md`](NOTICE.md).

The bundled Bitter typeface is under the SIL Open Font License 1.1; its licence travels with
it in [`fonts/bitter/OFL.txt`](fonts/bitter/OFL.txt).
