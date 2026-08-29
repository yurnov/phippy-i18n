# Contributing

Translations of CNCF Phippy books into Ukrainian and Polish. Native speakers welcome —
especially reviewers. Neither translation has been reviewed by anyone but its author yet, so
review is worth more here than new text.

## Ground rules

1. **`books/<book>/en.md` is the source of truth.** Translate from English, never from
   another translation. Do not edit `en.md` except to correct a genuine transcription error
   against the published CNCF PDF.
2. **Keep the page structure.** Page numbering and the story / technical-note alternation are
   fixed by the illustrations. One page in `book.json` = one page in every language file, and
   the build refuses to run if they disagree.
3. **Terminology comes from the glossary,** not from instinct. See `glossary/uk.md` and
   `glossary/pl.md`. If a term is missing, add it there in the same PR, with a one-line
   rationale and a source.
4. **Do not literally translate Kubernetes API kinds.** Follow what the Kubernetes
   documentation localizations and the CNCF Cloud Native Glossary already established. A
   familiar English term beats an invented native one.
5. **Register matters.** Story pages are a children's book — warm, simple, read-aloud. Technical
   notes are documentation — precise and neutral. The original switches between the two; so
   should the translation.
6. **Attribution is a licence condition.** Anything derived from this repo carries the credits
   in `NOTICE.md`, the `phippy.io` attribution, and a note that changes were made.

## The file format

Each `books/<book>/<lang>.md` starts with a front-matter block, then free notes for humans,
then the pages. Everything above the first `## p` heading is ignored by the build.

```markdown
---
lang: uk
language: Українська
title: Ілюстрований дитячий путівник по Kubernetes
status: draft
translators:
  - Юрій Новоставський
reviewers:
---

Notes to other translators go here. The build never reads them.

## p12 — anything after the page number is a note to reviewers

A paragraph. Single newlines inside it reflow, so wrap however you like.

## p13 — note page

### The level-3 heading is the note page's title

- a list item is a bullet
  - indented two spaces for a sub-bullet

The paragraph after the bullets is the caption under the illustration.
```

Inline, `*text*` is the only markup, and it means italic.

Two page kinds use the blocks differently, and the build checks for it:

- **Note pages** (`p5`, `p7`, … `p21`) need a `###` title and at least one bullet. They become
  the title, the bullet column and the caption.
- **The credits page** (`p2`) renders paragraphs and list items in the order you write them,
  each list item on its own line with no bullet, and a `>` block quote as the fine print at
  the foot of the page. **Put the translation credit here** — this is the page that has to
  say who translated the book.

There is no YAML parser involved: front matter supports `key: value` and `key:` followed by
indented `- item` lines, and nothing else.

## Checking your work

```sh
tools/build.sh childrens-guide-to-kubernetes uk
```

`tools/build_book.py` runs first and is the part that catches mistakes — a missing page, a
page that is not in `book.json`, a note page with no title or no bullets, artwork that has not
been extracted. It only needs `python3`, so you can run it without installing Typst:

```sh
python3 tools/build_book.py childrens-guide-to-kubernetes uk
```

Opening a pull request builds every edition and attaches the PDFs to the run, so you can look
at the result without building anything locally.

## A note on length

Ukrainian and Polish both run longer than English, and the page layout is fixed by the
illustrations. The template shrinks type to fit rather than reflowing the page, so an
over-long paragraph does not break the build — it quietly makes that page's text smaller than
its neighbours'. If a page looks noticeably tighter than the ones around it, the fix is a
shorter sentence, not a layout change.

## Reviewing

Review the markdown, not the PDF. Reviewing text is cheap; reviewing typeset pages is not.

Useful things to check, in rough order of value:

- Does it read aloud well to a child? Read it out loud. This matters more than fidelity.
- Is terminology consistent with the glossary and with itself?
- Are character names and their grammatical gender handled consistently
  (Phippy is *she* throughout)?
- Does each page still fit the illustration it belongs to?

## Licence

By contributing you agree your work is licensed **CC-BY-4.0**, matching the original.
