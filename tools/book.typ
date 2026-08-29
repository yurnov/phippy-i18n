// Typesets one language edition of a Phippy book from the JSON that
// tools/build_book.py produces.
//
//   typst compile --root . --font-path fonts \
//     --input book=/build/childrens-guide-to-kubernetes-uk.json \
//     tools/book.typ build/childrens-guide-to-kubernetes-uk.pdf
//
// The geometry below is measured from the published CNCF PDF: an 11x8.5in
// landscape page, artwork filling the top 528pt, and a caption under it. The
// colours and the diagram positions are not guessed either — tools/extract_art.py
// samples them from the same file into art/layout.json.

#let data = json("/" + sys.inputs.book)

#let PW = data.page.width * 1pt
#let PH = data.page.height * 1pt

#let ART-H = 528pt // the artwork band, full width, flush to the top
#let CAP-X = 36pt // caption text block
#let CAP-W = 724pt
#let CAP-MID = 542pt // captions sit centred on this line
#let CAP-H = 128pt
#let RULE-Y = data.layout.rule_y * ART-H
#let TITLE-MID = 52pt
#let BULLET-X = 64pt
#let BULLET-TOP = 158pt
#let BULLET-W = 340pt
#let CREDITS-TOP = 150pt // the credits block sits centred in this band
#let CREDITS-BOT = 500pt
#let FADE-TOP = 421pt // where the artwork starts fading into the page
#let FADE-BOT = 520pt

#let TEAL = rgb(data.layout.palette.title)
#let BLUE = rgb(data.layout.palette.bullet)
#let WASH = data.layout.palette.wash.map(rgb)

#let art(page) = image("/" + page.art, width: PW)

// Runs come out of the builder as {text, em} pairs; `*x*` is the only markup.
#let inline(runs) = {
  for r in runs {
    if r.em { emph(r.text) } else { r.text }
  }
}

// Shrink until it fits. Ukrainian and Polish both run longer than the English
// the boxes were drawn for, and the layout is fixed by the illustrations, so
// something has to give and it should be the type size rather than the page.
#let fit(body, width: CAP-W, height: CAP-H, start: 16pt, min: 10.5pt) = (
  context {
    let size = start
    while size > min and measure(block(width: width, text(size: size, body))).height > height {
      size -= 0.25pt
    }
    text(size: size, body)
  }
)

#let at(x, y, body) = place(top + left, dx: x, dy: y, body)

// A caption block, vertically centred on CAP-MID rather than top-aligned, which
// is how the original sets them.
#let caption(body, align-as: "justify", size: 16pt) = context {
  let content = fit(body, start: size)
  let h = measure(block(width: CAP-W, content)).height
  at(
    CAP-X,
    CAP-MID - h / 2,
    block(width: CAP-W, {
      set par(justify: align-as == "justify", leading: 0.55em)
      set align(if align-as == "center" { center } else { left })
      content
    }),
  )
}

#let paragraphs(page) = {
  for b in page.blocks {
    if b.type == "para" [#inline(b.runs)#parbreak()]
  }
}

// Every illustrated page in the original fades the artwork out behind its
// caption rather than butting text against a hard edge.
#let fade-out() = {
  place(top + left, dy: FADE-TOP, rect(
    width: PW,
    height: FADE-BOT - FADE-TOP,
    fill: gradient.linear(rgb(255, 255, 255, 0), white, angle: 90deg),
  ))
  place(top + left, dy: FADE-BOT, rect(width: PW, height: PH - FADE-BOT, fill: white))
}

#let bullets(items) = {
  set par(leading: 0.5em, justify: false)
  set text(hyphenate: false)
  set block(spacing: 0.3em)
  for (i, item) in items.enumerate() {
    if i > 0 { v(0.75em, weak: true) }
    grid(
      columns: (0.8em, 1fr),
      gutter: 0pt,
      [•], inline(item.runs),
    )
    for child in item.children {
      grid(
        columns: (2em, 0.8em, 1fr),
        gutter: 0pt,
        [], [>], inline(child),
      )
    }
  }
}

#let wash-fill(height) = gradient.linear(
  ..WASH.enumerate().map(((i, c)) => (c, i / (WASH.len() - 1) * 100%)),
  angle: 90deg,
)

// ---------------------------------------------------------------- page kinds

#let cover-page(page) = context {
  let im = art(page)
  let h = measure(im).height
  place(top + left, dy: h, rect(
    width: PW,
    height: PH - h,
    fill: gradient.linear(
      rgb(data.layout.cover.seam),
      rgb(data.layout.cover.foot),
      angle: 90deg,
    ),
  ))
  at(0pt, 0pt, im)
  at(56pt, h + 56pt, block(width: PW - 112pt, {
    set par(leading: 0.32em, justify: false)
    set text(hyphenate: false)
    fit(
      text(fill: white, weight: 500, data.title),
      width: PW - 112pt,
      height: PH - h - 100pt,
      start: 48pt,
      min: 26pt,
    )
  }))
}

#let credits-page(page) = {
  // The CNCF logo goes under the opening line, where the original has it.
  // Width only, never a height as well: the brand guidelines are explicit that
  // the mark must not be scaled away from its own proportions.
  let logo-after = page.blocks.position(b => b.type == "para")
  let body = {
    set align(center)
    set par(leading: 0.6em, justify: false)
    for (i, b) in page.blocks.enumerate() {
      if b.type == "para" {
        text(size: 1em)[#inline(b.runs)]
        v(0.8em)
        if i == logo-after and page.at("art", default: none) != none {
          image("/" + page.art, width: 300pt)
          v(1.2em)
        }
      } else if b.type == "lines" {
        set text(size: 1.06em)
        for item in b.items {
          inline(item.runs)
          linebreak()
        }
        v(0.8em)
      }
    }
  }

  // Sizes inside `body` are relative, so this shrinks the whole block together
  // when a language adds more credits than the original page was drawn for.
  at(96pt, CREDITS-TOP, block(
    width: PW - 192pt,
    height: CREDITS-BOT - CREDITS-TOP,
    align(center + horizon, fit(
      body,
      width: PW - 192pt,
      height: CREDITS-BOT - CREDITS-TOP,
      start: 17pt,
      min: 11pt,
    )),
  ))

  at(54pt, CREDITS-BOT, block(width: PW - 108pt, height: PH - CREDITS-BOT, {
    set align(center + horizon)
    set par(leading: 0.5em, justify: false)
    set text(size: 11pt, fill: luma(60))
    for b in page.blocks {
      if b.type == "fine" {
        for p in b.paras [#inline(p)#parbreak()]
      }
    }
  }))
}

#let illustrated-page(page, align-as: "justify", size: 16pt) = {
  at(0pt, 0pt, art(page))
  fade-out()
  caption(paragraphs(page), align-as: align-as, size: size)
}

#let note-page(page) = {
  place(top + left, rect(width: PW, height: ART-H, fill: wash-fill(ART-H)))

  place(top + left, dy: RULE-Y, line(
    length: PW,
    stroke: (paint: white, thickness: 3pt, dash: (24pt, 14pt)),
  ))

  // The diagram is cut out of the original slide with a real alpha channel, so
  // it drops straight back onto the wash where it came from — over the rule,
  // which is how the original stacks them.
  let d = page.diagram
  place(
    top + left,
    dx: d.x * PW,
    dy: d.y * ART-H,
    image("/" + page.art, width: d.w * PW, height: d.h * ART-H),
  )

  at(0pt, 0pt, block(width: PW, height: TITLE-MID * 2, {
    set align(center + horizon)
    set text(hyphenate: false)
    fit(
      text(fill: TEAL, inline(page.title)),
      width: PW - 96pt,
      height: TITLE-MID * 2,
      start: 54pt,
      min: 30pt,
    )
  }))

  // The bullets share the band with the diagram: usually beside it, but on the
  // labels page the diagram sits underneath, so they get the full width and a
  // shorter run instead.
  let under = d.x * PW < BULLET-X + 80pt
  let bw = if under { PW - 2 * BULLET-X } else {
    calc.min(BULLET-W, d.x * PW - BULLET-X - 16pt)
  }
  let bh = if under { d.y * ART-H - BULLET-TOP - 16pt } else { FADE-TOP - BULLET-TOP }
  at(BULLET-X, BULLET-TOP, block(width: bw, {
    set text(fill: BLUE)
    fit(bullets(page.blocks.find(b => b.type == "lines").items),
      width: bw, height: bh, start: 19pt, min: 12pt)
  }))

  fade-out()
  caption(paragraphs(page))
}

#let back-page(page) = {
  place(top + left, rect(width: PW, height: PH, fill: wash-fill(PH)))
  place(top + left, dx: 146pt, dy: 210pt, block(width: PW - 292pt, {
    set align(center)
    set par(leading: 0.6em)
    let blocks = page.blocks.filter(b => b.type == "para")
    if blocks.len() > 0 {
      text(size: 22pt, fill: rgb("#31485c"))[#inline(blocks.at(0).runs)]
      v(24pt)
    }
    set text(size: 12pt, fill: rgb("#40566a"))
    for b in blocks.slice(1) [#inline(b.runs)#parbreak()]
  }))
}

// -------------------------------------------------------------------- output

#set document(
  title: data.title,
  author: if data.translators.len() > 0 { data.translators } else { () },
)
#set page(width: PW, height: PH, margin: 0pt, fill: white)
#set text(font: "Bitter", lang: data.lang, hyphenate: true, fill: rgb("#1c1c1c"))

#for (i, page) in data.pages.enumerate() {
  if i > 0 { pagebreak() }
  if page.kind == "cover" { cover-page(page) } else if page.kind == "credits" {
    credits-page(page)
  } else if page.kind == "dedication" {
    illustrated-page(page, align-as: "center", size: 14pt)
  } else if page.kind == "note" { note-page(page) } else if page.kind == "back" {
    back-page(page)
  } else { illustrated-page(page) }
}
