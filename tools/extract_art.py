#!/usr/bin/env python3
"""Extract the book artwork from the published CNCF PDF into books/<slug>/art/.

The published PDF keeps its text in a live text layer, so the embedded raster
images are the illustrations *without* the English wording — except on the
technical-note pages, where the whole slide (title, bullets and diagram) was
flattened into one image, and on the front cover, where the title is painted
over the water.

For those two cases the English is removed here:

* note pages   the page background is a plain vertical watercolour wash, so the
               ink can be separated from it by difference matting and the
               diagram cut out on its own with a real alpha channel.
* front cover  the title sits over open water, so the artwork is cut above it
               and layout.json carries the colours to carry the water on with.

Run rarely — the output is committed. Needs pymupdf, pillow and numpy:

    docker run --rm -v "$PWD:/w" -w /w python:3.12-slim \
        bash -c "pip install -q pymupdf pillow numpy && python tools/extract_art.py"
"""
from __future__ import annotations

import json
import pathlib
import sys
import urllib.request

import numpy as np
import pymupdf
from PIL import Image

SOURCE_URL = (
    "https://www.cncf.io/wp-content/uploads/2020/08/"
    "The-Illustrated-Childrens-Guide-to-Kubernetes.pdf"
)
ROOT = pathlib.Path(__file__).resolve().parent.parent
PDF = ROOT / "sources" / "childrens-guide-en.pdf"
ART = ROOT / "books" / "childrens-guide-to-kubernetes" / "art"

STORY_PAGES = [4, 6, 8, 10, 12, 14, 16, 18, 20, 22]
NOTE_PAGES = [5, 7, 9, 11, 13, 15, 17, 19, 21]

# Where the diagram sits on each note page, as a fraction of the slide image.
# Chosen to clear the title band and the bullet column; the cut-out is then
# trimmed to the ink it actually contains, so a generous box costs nothing.
DIAGRAM_BOX = {
    5:  (0.480, 0.27, 0.93, 0.72),
    7:  (0.470, 0.27, 0.93, 0.65),
    9:  (0.520, 0.27, 1.00, 0.88),
    11: (0.060, 0.50, 1.00, 0.88),
    13: (0.478, 0.27, 0.96, 0.78),
    15: (0.420, 0.27, 1.00, 1.00),
    17: (0.495, 0.20, 1.00, 1.00),
    19: (0.495, 0.20, 1.00, 1.00),
    21: (0.495, 0.20, 1.00, 1.00),
}

# The cover title occupies everything below this line; only open water is there.
COVER_TITLE_TOP = 0.50

STORY_WIDTH = 2200      # px; 792pt page at ~200dpi is 2200px
NOTE_WIDTH = 1920       # px on the full slide before cropping
JPEG_QUALITY = 85

MATTE_LO, MATTE_HI = 14.0, 34.0   # RGB distance from the wash: 0% .. 100% alpha


def fetch_source() -> None:
    if PDF.exists():
        return
    PDF.parent.mkdir(parents=True, exist_ok=True)
    print(f"downloading {SOURCE_URL}")
    urllib.request.urlretrieve(SOURCE_URL, PDF)


def page_image(doc: pymupdf.Document, pno: int) -> Image.Image:
    """The one full-page illustration on a page, largest first."""
    imgs = [x for x in doc[pno - 1].get_images(full=True) if x[2] > 50]
    if not imgs:
        raise SystemExit(f"p{pno}: no image found")
    xref = max(imgs, key=lambda x: x[2] * x[3])[0]
    raw = doc.extract_image(xref)
    return Image.open(pymupdf.io.BytesIO(raw["image"])).convert("RGB")


def wash_gradient(doc: pymupdf.Document, height: int) -> np.ndarray:
    """The note-page background, as one colour per row.

    Every note page shares the same wash, and on any given row the ink is a
    minority of the pixels, so the median over columns recovers the background
    and the median over pages removes what little the ink still skews.
    """
    rows = []
    for pno in NOTE_PAGES:
        im = page_image(doc, pno).resize((NOTE_WIDTH, height), Image.LANCZOS)
        rows.append(np.median(np.asarray(im, dtype=np.float32), axis=1))
    bg = np.median(np.stack(rows), axis=0)
    # The dashed rule spans the full width on every page at the same height, so
    # it survives both medians and leaves a bright spike in the gradient. A
    # median along the rows themselves removes it; the wash is smooth enough
    # vertically that nothing else is lost.
    k = 21
    padded = np.pad(bg, ((k // 2, k // 2), (0, 0)), mode="edge")
    windows = np.lib.stride_tricks.sliding_window_view(padded, k, axis=0)
    return np.median(windows, axis=2)


def matte(px: np.ndarray, bg: np.ndarray) -> np.ndarray:
    """Difference matting: RGBA with the wash turned transparent.

    Colours are un-premultiplied so the cut-out composites correctly over any
    background, which is what keeps the drop shadows under the diagram cards
    looking like shadows rather than grey smears.
    """
    d = np.abs(px - bg).max(axis=2)
    a = np.clip((d - MATTE_LO) / (MATTE_HI - MATTE_LO), 0.0, 1.0)
    col = np.clip(bg + (px - bg) / np.maximum(a, 1e-3)[..., None], 0, 255)
    return np.dstack([col, a * 255]).astype(np.uint8)


def trim(rgba: np.ndarray, pad: int = 8) -> tuple[np.ndarray, tuple[int, int, int, int]]:
    """Crop to the ink, returning the image and its box in the input's pixels."""
    solid = rgba[..., 3] > 20
    ys, xs = np.where(solid)
    if len(ys) == 0:
        raise SystemExit("empty cut-out")
    y0, y1 = max(int(ys.min()) - pad, 0), min(int(ys.max()) + pad + 1, rgba.shape[0])
    x0, x1 = max(int(xs.min()) - pad, 0), min(int(xs.max()) + pad + 1, rgba.shape[1])
    return rgba[y0:y1, x0:x1], (x0, y0, x1, y1)


def _dilate(a: np.ndarray, n: int) -> np.ndarray:
    for _ in range(n):
        a = np.maximum.reduce(
            [a, np.roll(a, 1, 0), np.roll(a, -1, 0), np.roll(a, 1, 1), np.roll(a, -1, 1)]
        )
    return a


def _blur(a: np.ndarray, n: int) -> np.ndarray:
    for _ in range(n):
        a = (
            a
            + np.roll(a, 1, 0)
            + np.roll(a, -1, 0)
            + np.roll(a, 1, 1)
            + np.roll(a, -1, 1)
        ) / 5.0
    return a


def crop_cover(im: Image.Image) -> tuple[Image.Image, str, str]:
    """Everything above the English title, plus the two colours that continue it.

    Painting the lettering out of the water leaves visible scrubbing whichever
    way it is filled, and there is nothing behind it worth recovering — it is
    open water. Cutting above it and carrying the water on as a gradient gives
    the translated title a clean surface and no seam to hide.
    """
    px = np.asarray(im, dtype=np.float32)
    h = px.shape[0]
    top = int(COVER_TITLE_TOP * h)

    def hexcolor(c) -> str:
        return "#%02x%02x%02x" % tuple(int(round(v)) for v in c)

    seam = np.median(px[top - 8 : top].reshape(-1, 3), axis=0)
    foot = np.median(px[int(0.965 * h) :].reshape(-1, 3), axis=0)
    return im.crop((0, 0, px.shape[1], top)), hexcolor(seam), hexcolor(foot)


def _ink_median(doc, pno, bg, y0, y1, x0, x1) -> np.ndarray:
    """Median colour of the solid ink inside a region of a note page.

    Taking the median of what the matte says is fully opaque gives the colour as
    drawn, rather than the most extreme antialiased pixel in the region.
    """
    h, w = bg.shape[0], bg.shape[1]
    im = page_image(doc, pno).resize((w, h), Image.LANCZOS)
    rgba = matte(np.asarray(im, dtype=np.float32), bg)
    box = rgba[int(y0 * h) : int(y1 * h), int(x0 * w) : int(x1 * w)]
    solid = box[..., 3] > 240
    return np.median(box[..., :3][solid], axis=0)


def rule_y(doc: pymupdf.Document, bg: np.ndarray) -> float:
    """Vertical position of the dashed rule, as a fraction of the slide image.

    Measured on p5, in the left margin where no diagram or bullet reaches, by
    finding the row carrying the most pure white.
    """
    h, w = bg.shape[0], bg.shape[1]
    im = page_image(doc, 5).resize((w, h), Image.LANCZOS)
    lum = np.asarray(im, dtype=np.float32).mean(axis=2)
    y0, x0, x1 = int(0.18 * h), int(0.02 * w), int(0.30 * w)
    band = (lum[y0 : int(0.34 * h), x0:x1] > 245).sum(axis=1)
    return round((y0 + int(band.argmax())) / h, 4)


def sample_palette(doc: pymupdf.Document, bg1d: np.ndarray, bg: np.ndarray) -> dict:
    """The wash gradient stops, plus the title and bullet colours."""

    def hexcolor(c) -> str:
        return "#%02x%02x%02x" % tuple(int(round(v)) for v in c)

    stops = [hexcolor(bg1d[int(f * (len(bg1d) - 1))]) for f in (0.0, 0.25, 0.5, 0.75, 1.0)]
    return {
        "wash": stops,
        "title": hexcolor(_ink_median(doc, 21, bg, 0.03, 0.20, 0.20, 0.80)),
        "bullet": hexcolor(_ink_median(doc, 17, bg, 0.30, 0.85, 0.03, 0.40)),
        "_note": "sampled from the published CNCF PDF by tools/extract_art.py",
    }


def main() -> None:
    fetch_source()
    ART.mkdir(parents=True, exist_ok=True)
    doc = pymupdf.open(PDF)

    height = round(NOTE_WIDTH * 2560 / 3840)
    bg1d = wash_gradient(doc, height)
    bg = np.repeat(bg1d[:, None, :], NOTE_WIDTH, axis=1)

    placement: dict[str, dict] = {}

    def save_jpeg(im: Image.Image, name: str, width: int = STORY_WIDTH) -> None:
        im = im.resize((width, round(width * im.height / im.width)), Image.LANCZOS)
        path = ART / name
        im.save(path, "JPEG", quality=JPEG_QUALITY, optimize=True, progressive=True)
        print(f"  {name:20s} {im.width}x{im.height}  {path.stat().st_size // 1024} KB")

    print("cover and front matter")
    cover, seam, foot = crop_cover(page_image(doc, 1))
    save_jpeg(cover, "cover.jpg")
    save_jpeg(page_image(doc, 3), "dedication.jpg")

    print("story pages")
    for pno in STORY_PAGES:
        save_jpeg(page_image(doc, pno), f"story-{pno:02d}.jpg")

    print("note diagrams")
    for pno in NOTE_PAGES:
        im = page_image(doc, pno).resize((NOTE_WIDTH, height), Image.LANCZOS)
        rgba = matte(np.asarray(im, dtype=np.float32), bg)
        fx0, fy0, fx1, fy1 = DIAGRAM_BOX[pno]
        bx0, by0 = int(fx0 * NOTE_WIDTH), int(fy0 * height)
        bx1, by1 = int(fx1 * NOTE_WIDTH), int(fy1 * height)
        cut, (tx0, ty0, tx1, ty1) = trim(rgba[by0:by1, bx0:bx1])
        name = f"note-{pno:02d}.png"
        Image.fromarray(cut, "RGBA").save(ART / name, optimize=True)
        # Where this sits on the slide, as a fraction of the page's image area.
        placement[str(pno)] = {
            "x": round((bx0 + tx0) / NOTE_WIDTH, 4),
            "y": round((by0 + ty0) / height, 4),
            "w": round((tx1 - tx0) / NOTE_WIDTH, 4),
            "h": round((ty1 - ty0) / height, 4),
        }
        print(
            f"  {name:20s} {cut.shape[1]}x{cut.shape[0]}"
            f"  {(ART / name).stat().st_size // 1024} KB"
        )

    out = {
        "palette": sample_palette(doc, bg1d, bg),
        "rule_y": rule_y(doc, bg),
        "cover": {"seam": seam, "foot": foot},
        "diagrams": placement,
    }
    (ART / "layout.json").write_text(json.dumps(out, indent=2) + "\n", encoding="utf-8")
    print("\nlayout.json")
    print(json.dumps(out["palette"], indent=2))


if __name__ == "__main__":
    sys.exit(main())
