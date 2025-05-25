// 

// horizontal rule function for pandoc compatibility
#let horizontalrule = {
  v(2em, weak: true)
  align(center)[
    #line(
      start: (20%, 0%),
      end: (80%, 0%),
      stroke: 1pt + rgb("#d1d5db")
    )
  ]
  v(2em, weak: true)
}

$if(smart)$
$else$
#set smartquote(enabled: false)
$endif$

// sidenote counter for numbered notes
#let notecounter = counter("sidenote")

// sidenote function - replaces drafting package functionality
#let note(dy: -1em, numbered: true, content) = {
  if numbered {
    notecounter.step()
    // display number in text
    text(size: 0.75em, baseline: 0.2em, fill: rgb("#1d4ed8"))[
      #super(notecounter.display())
    ]
  }
  
  // place the note in right margin using built-in place function
  place(
    right,
    dx: 1in,  // offset into right margin
    dy: dy,
    block(
      width: 2.2in,  // note width in margin
      inset: (left: 0.5em, right: 0.2em, top: 0.2em, bottom: 0.2em),
      fill: rgb("#fefefe"),
      stroke: (left: 2pt + rgb("#e5e7eb")),
      radius: (right: 2pt),
      text(
        size: 8.5pt,
        font: ("Fira Sans", "system-ui", "sans-serif"),
        fill: rgb("#374151"),
        {
          if numbered {
            text(weight: 600, size: 9pt)[
              #super(notecounter.display())#h(0.3em)
            ]
          }
          content
        }
      )
    )
  )
}

// citation sidenote function
#let notecite(dy: -1em, supplement: none, key) = context {
  let bib_queries = query(bibliography)
  if bib_queries.len() > 0 {
    // display inline citation
    cite(key, supplement: supplement, style: "ieee")
    // add sidenote with full citation
    note(
      dy: dy,
      numbered: false,
      cite(key, form: "full", style: "chicago-author-date")
    )
  }
}

#let conf(
  title: none,
  subtitle: none, 
  author: none,
  date: none,
  abstract: none,
  vibe: "tufte",
  fontsize: 11pt,
  pagestyle: "tufte",
  toc: false,
  bibliography: none,
  doc,
) = {
  let fonts = (
    serif: ("ETBembo"),
    sans: ("Gill Sans"),
    mono: ("SF Mono"),
  )
  
  // page setup with wide right margin for sidenotes
  set page(
    paper: "us-letter",
    margin: (
      left: 1in,
      right: 3.5in,    // wide right margin for sidenotes
      top: 1.5in,
      bottom: 1.5in
    ),
    numbering: "1",
    header: context {
      set text(font: fonts.sans, size: 9pt, fill: rgb("#6b7280"))
      if counter(page).get().first() > 1 {
        if title != none {
          align(right, upper(title))
        }
      }
    },
    footer: context {
      set text(font: fonts.sans, size: 8pt, fill: rgb("#6b7280"))
      align(center)[
        Page #counter(page).display()
      ]
    }
  )
  
  let base-font-size = fontsize

  // vibe-specific adjustments
  let adjustment_config = (
    classic: (
      font-size: base-font-size,
      spacing: 1em, 
      leading: 0.8em,
      list-spacing: 0.8em,
    ),
    alternate: (
      font-size: base-font-size * 0.95,
      spacing: 1em, 
      leading: 0.8em,
      list-spacing: 0.8em,
    ),
    artistic: (
      font-size: base-font-size * 0.9,
      spacing: 1.4em, 
      leading: 1em,
      list-spacing: 1em,
    ),
    tufte: (
      font-size: base-font-size,
      spacing: 0.65em,
      leading: 0.65em,
      list-spacing: 0.65em,
    ),
  )
  let adjustments = adjustment_config.at(vibe, default: adjustment_config.tufte)
  
  // body text setup
  set text(
    font: fonts.serif,
    size: adjustments.font-size,
    lang: "en",
    fill: rgb("#1f2937"),  // slightly softer than pure black
    hyphenate: true,
  )
  
  set par(
    justify: true,
    leading: adjustments.leading,
    spacing: adjustments.spacing,
    first-line-indent: 1em,
  )
  
  // heading styling inspired by both templates
  set heading(numbering: none)
  
  show heading: it => {
    // spacing before heading
    v(if it.level == 1 { 3em } else if it.level == 2 { 2em } else { 1.5em }, weak: true)
    
    if it.level == 1 {
      // large headings, tufte style
      text(
        size: 1.6em,
        weight: 400,
        font: fonts.sans,
        fill: rgb("#1f2937"),
        upper(it)
      )
    } else if it.level == 2 {
      // medium headings
      text(
        size: 1.3em,
        weight: 400,
        style: "italic", 
        font: fonts.serif,
        fill: rgb("#374151"),
        it
      )
    } else {
      // small headings
      text(
        size: 1.1em,
        style: "italic",
        weight: 300,
        font: fonts.serif,
        fill: rgb("#4b5563"),
        it
      )
    }
    
    // spacing after heading
    v(if it.level == 1 { 1.5em } else { 1em }, weak: true)
  }
  
  // tables with clean styling
  set table(
    stroke: (x, y) => {
      if y == 0 { 
        (bottom: 1.5pt + rgb("#374151"))
      } else {
        (bottom: 0.5pt + rgb("#e5e7eb"))
      }
    },
    fill: none,
    inset: (x: 0.8em, y: 0.6em),
  )
  
  show table.cell.where(y: 0): it => {
    text(weight: 600, fill: rgb("#1f2937"), font: fonts.sans, it)
  }
  
  show table: it => {
    v(1.2em, weak: true)
    set text(size: adjustments.font-size * 0.9, font: fonts.sans)
    it
    v(1em, weak: true)
  }
  
  // enhanced quote styling
  set quote(block: true)
  
  show quote: it => {
    v(1em, weak: true)
    block(
      inset: (left: 2em, top: 1em, bottom: 1em, right: 1em),
      stroke: none,
      width: 100%,
      [
        #set text(style: "italic", fill: rgb("#4b5563"), size: 0.95em)
        #set par(spacing: 0.6em, first-line-indent: 0pt)
        
        #it.body
        
        #if it.attribution != none {
          v(0.6em)
          align(right)[
            #text(
              size: 0.85em, 
              style: "normal",
              weight: 500,
              font: fonts.sans,
              fill: rgb("#6b7280"),
              [— #it.attribution]
            )
          ]
        }
      ]
    )
    v(1em, weak: true)
  }
  
  // list styling
  set list(
    spacing: auto,
    marker: (
      text(fill: rgb("#6b7280"), "•"),
      text(fill: rgb("#6b7280"), "‣"), 
      text(fill: rgb("#6b7280"), "◦"),
    )
  )
  
  set enum(
    spacing: auto,
  )
  
  show list: set par(justify: false)
  show enum: set par(justify: false)
  
  // figures and captions
  show figure: set figure.caption(separator: [.#h(0.5em)])
  show figure.caption: set align(left)
  show figure.caption: set text(font: fonts.sans, size: 0.9em, fill: rgb("#4b5563"))
  
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure(numbering: "I")
  show figure.where(kind: image): set figure(supplement: [Figure], numbering: "1")
  
  // code blocks
  show raw.where(block: true): it => {
    v(1em)
    block(
      fill: rgb("#f8f9fa"),
      inset: 14pt,
      radius: 4pt,
      width: 100%,
      stroke: 1pt + rgb("#e9ecef"),
      text(
        font: fonts.mono,
        size: 0.85em,
        fill: rgb("#1f2937"),
        it
      )
    )
    v(1em)
  }
  
  show raw.where(block: false): it => {
    box(
      fill: rgb("#f8f9fa"),
      inset: (x: 4pt),
      outset: (y: 2pt),
      radius: 2pt,
      stroke: 0.5pt + rgb("#e9ecef"),
      text(
        font: fonts.mono,
        size: 0.9em,
        fill: rgb("#dc2626"),
        it
      )
    )
  }
  
  // links and emphasis
  show link: it => text(fill: rgb("#1d4ed8"), underline(it))
  show emph: it => text(style: "italic", it)
  show strong: it => text(weight: 600, it)
  
  // footnotes
  show footnote: it => {
    super(
      text(
        fill: rgb("#1d4ed8"), 
        size: 0.75em,
        it
      )
    )
  }
  
  // math equations
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)
  
  // document header/title block in tufte style
  if title != none or subtitle != none or author != none or date != none {
    
    if title != none {
      block(
        width: 100%,
        inset: (bottom: 1em),
        text(
          size: 2.2em,
          weight: 300,
          font: fonts.sans,
          fill: rgb("#1f2937"),
          hyphenate: false,
          upper(title)
        )
      )
    }
    
    if subtitle != none {
      block(
        width: 100%,
        inset: (bottom: 0.8em),
        text(
          size: 1.3em,
          style: "italic",
          weight: 300,
          font: fonts.serif,
          fill: rgb("#4b5563"),
          subtitle  
        )
      )
    }
    
    if author != none or date != none {
      block(
        width: 100%,
        inset: (bottom: 1.5em),
        text(
          size: 1em,
          weight: 400,
          font: fonts.sans,
          fill: rgb("#6b7280"),
          [
            #if author != none { upper(author) }
            #if author != none and date != none { linebreak() }
            #if date != none { date }
          ]
        )
      )
    }
    
    v(1em)
  }
  
  // abstract block
  if abstract != none {
    block(
      width: 100%,
      inset: (x: 2em, y: 1em, bottom: 2em),
      stroke: (top: 2pt + rgb("#e5e7eb")),
      [
        #set text(font: fonts.sans, size: 0.9em, fill: rgb("#4b5563"))
        #set par(hanging-indent: 0pt, justify: true, first-line-indent: 0pt)
        
        #text(weight: 600, size: 1em)[Abstract]
        #v(0.5em)
        #abstract
      ]
    )
  }
  
  // table of contents
  if toc {
    block(
      width: 100%,
      inset: (bottom: 2em),
      [
        #set text(font: fonts.sans, size: 0.9em)
        #outline(indent: 1em, title: none, depth: 2)
      ]
    )
  }
  
  doc
  
  // bibliography
  if bibliography != none {
    v(2em)
    text(
      size: 1.3em,
      weight: 400,
      font: fonts.sans,
      fill: rgb("#1f2937"),
      [References]
    )
    v(1em)
    
    show bibliography: set text(font: fonts.sans, size: 0.9em)
    show bibliography: set par(justify: false, first-line-indent: 0pt)
    set bibliography(title: none)
    bibliography
  }
}

// main template function - pandoc integration
#show: doc => conf(
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(author)$
  author: [$author$],
$endif$
$if(date)$
  date: [$date$],
$endif$
$if(abstract)$
  abstract: [$abstract$],
$endif$
$if(vibe)$
  vibe: "$vibe$",
$endif$
$if(fontsize)$
  fontsize: $fontsize$,
$endif$
$if(pagestyle)$
  pagestyle: "$pagestyle$",
$endif$
$if(toc)$
  toc: $toc$,
$endif$
$if(bibliography-file)$
  bibliography: bibliography("$bibliography-file$"),
$endif$
  doc,
)

$if(toc)$
$endif$

$body$