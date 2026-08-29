# Attribution

## Original work

**The Illustrated Children's Guide to Kubernetes**

- Written by: **Matt Butcher**
- Illustrated by: **Bailey Beougher**
- Designed by: **Karen Chu**
- Illustration of Goldie is based on the **Go Gopher** designed by **Renée French**
  (licensed CC-BY-3.0)

Phippy, Captain Kube, and The Children's Illustrated Guide to Kubernetes are copyright
**The Linux Foundation**, on behalf of the **Cloud Native Computing Foundation**. They are
licensed under **Creative Commons Attribution 4.0 International (CC-BY-4.0)**.

See <https://phippy.io> (redirects to <https://www.cncf.io/phippy/>).

Source PDF this translation works from:
<https://www.cncf.io/wp-content/uploads/2020/08/The-Illustrated-Childrens-Guide-to-Kubernetes.pdf>

## This work

Ukrainian and Polish translations by Yuriy Novostavskiy and contributors, licensed
**CC-BY-4.0** — the same terms as the original.

This is an **unofficial community translation**, not published or endorsed by CNCF.

## Changes made, as CC-BY-4.0 requires stating

- The text is translated into Ukrainian and Polish.
- The book is reset from scratch. It is **not** the original design file: the type is set in
  **Bitter** rather than the original Klinic Slab, and the pages are rebuilt from the
  measurements in `tools/book.typ` rather than reproduced.
- The illustrations under `books/*/art/` are extracted from the published CC-BY-4.0 PDF named
  above, by `tools/extract_art.py`. Two sets of them are modified: the technical-note diagrams
  are cut out of their page backgrounds, and the front cover is cropped above its title. No
  illustration is otherwise altered, redrawn or recoloured.
- The technical-note titles and bullet lists were transcribed by eye, because they are
  flattened into the page images rather than present as text.
- Two typos in the original are corrected rather than translated: "Philsophia" (p9) and
  "Kurbernetes" (p17).
- The CNCF logo on the credits page is the **current** horizontal colour lockup, where the
  2018 original carries the lockup of its day. See the trademark note below.

## Attribution requirements carried into every derived file

CC-BY-4.0 requires that the attribution above travels with the work. Concretely, any PDF,
web page, or printed copy produced from this repository must:

1. Credit Matt Butcher, Bailey Beougher and Karen Chu as the original creators.
2. Credit Renée French for the Go Gopher that Goldie is based on.
3. Include the text `phippy.io`, and where the medium allows, link to <https://phippy.io>.
4. State the CC-BY-4.0 licence and indicate that changes were made (i.e. that it is a
   translation).
5. Not imply that CNCF or the original authors endorse this translation.

The generated PDFs satisfy all five: the credits page carries 1, 2 and 3 plus the translation
credit, and 4 and 5 appear both there and on the back cover.

## CNCF trademarks

The credits page reproduces the **CNCF logo**, as the original does. CNCF trademarks are owned
by The Linux Foundation and are **not** covered by the CC-BY-4.0 licence on the book — their
use is governed by the [CNCF brand guidelines](https://www.cncf.io/brand-guidelines/) and the
Linux Foundation Trademark Usage Guidelines.

The mark used here is `other/cncf/horizontal/color/cncf-color.svg` from
[cncf/artwork](https://github.com/cncf/artwork), committed unchanged at
`books/*/art/cncf-color.svg`. It is reproduced in its full-colour form, with no change to its
colours or elements, scaled by width only so its proportions are preserved, and with clear
space around it — the four things the guidelines ask for.

It appears here to attribute the original work to CNCF, on the page whose purpose is
attribution. It is not used as a mark of this translation, and the same page states plainly
that this is an unofficial community translation which CNCF has not published or endorsed.

## Bundled typeface

**Bitter**, Copyright 2011 The Bitter Project Authors
(<https://github.com/solmatas/BitterPro>), with Reserved Font Name "Bitter Pro". Licensed
under the **SIL Open Font License, Version 1.1**, reproduced in
[`fonts/bitter/OFL.txt`](fonts/bitter/OFL.txt).

The OFL does not extend to documents produced with the font, so the generated PDFs remain
plain CC-BY-4.0 with no licence mixing. Bitter was chosen over the original Klinic Slab
because it is the nearest open-licensed slab serif covering both Cyrillic and the Polish
diacritics; Klinic Slab is a commercial Lost Type release and is not redistributed here.

## Prior art

- Italian edition, translated by Annalisa Gennaro (SparkFabrik), hosted by CNCF:
  <https://www.cncf.io/wp-content/uploads/2021/11/The-Illustrated-Childrens-Guide-to-Kubernetes-Italian-Spark.pdf>
- Japanese community translation: <https://github.com/sasukeh/Phippy-books-i18n-ja_jp>
