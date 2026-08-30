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

// Cover title, measured off the original: an 78pt slab set across a 740pt
// measure, with "Illustrated" written in above a proofreader's caret in red.
#let TITLE-TOP = 436pt // cap top of the first line
#let TITLE-W = 740pt
#let TITLE-MAX = 78pt
#let TITLE-ADVANCE = 0.96 // line to line, as a fraction of the size
#let RED = rgb(251, 7, 8)
#let SCRIPT-ANGLE = -13deg // the red word rises to the right
#let SCRIPT-RATIO = 0.90 // Pacifico size, relative to the title size
#let CARET-RATIO = 1.10 // caret width over its height, from the original
#let CARET-FILL = 0.78 // how much of the inter-line gap the caret takes up
#let SCRIPT-MARGIN = 36pt // the red word stops here
#let SCRIPT-LIFT = 0.10 // clearance above the line it is written over

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

// A proofreader's caret, drawn rather than set: the original is a brush mark,
// and a typographic "^" reads as punctuation instead of an annotation.
#let caret-mark(w, h) = {
  curve(
    stroke: (paint: RED, thickness: w * 0.30, cap: "round", join: "round"),
    curve.move((0pt, h)),
    curve.line((w / 2, 0pt)),
    curve.line((w, h)),
  )
}

#let cover-page(page) = context {
  let im = art(page)
  let art-h = measure(im).height
  place(top + left, dy: art-h, rect(
    width: PW,
    height: PH - art-h,
    fill: gradient.linear(
      rgb(data.layout.cover.seam),
      rgb(data.layout.cover.foot),
      angle: 90deg,
    ),
  ))
  at(0pt, 0pt, im)

  // The title is written one list item per typeset line, because the caret has
  // to land in a known word gap and automatic line breaking would move it.
  let group = page.blocks.find(b => b.type == "lines")
  let items = if group == none { () } else { group.items }

  // Lift the {marked} word out of the line it is written on: the printed title
  // reads without it, which is the whole joke.
  let split(item) = {
    let i = item.runs.position(r => r.ins)
    if i == none {
      (text: item.runs.map(r => r.text).join(""), word: none)
    } else {
      let before = item.runs.slice(0, i).map(r => r.text).join("").trim(at: end)
      let after = item.runs.slice(i + 1).map(r => r.text).join("")
      (text: before + after, word: item.runs.at(i).text, before: before, after: after)
    }
  }
  let lines = items.map(split)

  // cap-height as the box edge, so a line's top lands exactly where the
  // original's ink starts rather than an ascender above it.
  let styled(size, body) = text(
    font: "Bitter",
    size: size,
    weight: 500,
    top-edge: "cap-height",
    bottom-edge: "baseline",
    hyphenate: false,
    body,
  )
  let width-of(size, body) = measure(styled(size, body)).width

  let size = TITLE-MAX
  while (
    size > 24pt
      and lines.map(l => width-of(size, l.text)).fold(0pt, calc.max) > TITLE-W
  ) {
    size -= 0.5pt
  }

  for (i, l) in lines.enumerate() {
    let m = measure(styled(size, l.text))
    let w = m.width
    let x = (PW - w) / 2
    let y = TITLE-TOP + i * size * TITLE-ADVANCE
    at(x, y, text(fill: white, styled(size, l.text)))

    if l.word != none {
      // Midpoint of the space the word came out of: where `before` ends and
      // where `after` begins, halved.
      let gap = x + (width-of(size, l.before) + w - width-of(size, l.after)) / 2

      // The caret is sized to the gap between this line's baseline and the next
      // line's cap top. The original's is bigger and overlaps the line below,
      // which only works because "Kubernetes" happens to start clear of it — a
      // centred translated line lands right on top of it instead.
      let space = size * TITLE-ADVANCE - m.height
      let ch = space * CARET-FILL
      let cw = ch * CARET-RATIO
      at(gap - cw / 2, y + m.height + space * (1 - CARET-FILL) / 2, caret-mark(cw, ch))

      // The word is written in from the caret rightwards, as in the original.
      // "Illustrated" leaves room to spare; "ілюстрований" does not, so shrink
      // it until the rotated word clears the right margin.
      let word-at(s) = box(text(font: "Pacifico", size: s, fill: RED, l.word))
      let rotated-width(s) = {
        let m = measure(word-at(s))
        (
          m.width * calc.abs(calc.cos(SCRIPT-ANGLE))
            + m.height * calc.abs(calc.sin(SCRIPT-ANGLE))
        )
      }
      let word-x = gap - cw / 2
      let room = PW - SCRIPT-MARGIN - word-x
      let script = size * SCRIPT-RATIO
      while script > size * 0.40 and rotated-width(script) > room { script -= 0.5pt }

      let word = word-at(script)
      at(
        word-x,
        y - measure(word).height - size * SCRIPT-LIFT,
        rotate(SCRIPT-ANGLE, origin: bottom + left, word),
      )
    }
  }
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
