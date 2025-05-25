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
#let sidenote-counter = counter("sidenote")

// enhanced sidenote function with numbering
#let sidenote(content, numbered: true, dy: 0em) = {
  if numbered {
    sidenote-counter.step()
    // display superscript number in text
    super(text(size: 8pt, fill: rgb("#1d4ed8"))[#sidenote-counter.display()])
  }
  
  place(
    dx: 29em,
    dy: dy,
    block(
      breakable: false,
      width: 14em,
      inset: (left: 0.5em, right: 0.3em, top: 0.2em, bottom: 0.2em),
      text(
        font: ("Gill Sans MT", "Gill Sans", "Avenir", "system-ui"),
        size: 8.5pt,
        fill: rgb("#374151"),
        [
          #if numbered {
            super(text(size: 7pt, weight: 600)[#sidenote-counter.display()]) 
            h(0.3em)
          }
          #content
        ]
      )
    )
  )
}

// citation sidenote function  
#let sidecite(key, supplement: none, dy: 0em) = context {
  let bib_queries = query(bibliography)
  if bib_queries.len() > 0 {
    // inline citation
    cite(key, supplement: supplement, style: "chicago-author-date")
    // full citation in sidenote
    sidenote(
      numbered: false,
      dy: dy,
      cite(key, form: "full", style: "chicago-author-date")
    )
  }
}

// margin figure function
#let marginfigure(content, caption: none, dy: 0em) = {
  place(
    dx: 29em,
    dy: dy,
    block(
      breakable: false, 
      width: 14em,
      [
        #content
        #if caption != none {
          v(0.3em)
          text(
            font: ("Gill Sans MT", "Gill Sans", "system-ui"),
            size: 8pt,
            fill: rgb("#4b5563"),
            style: "italic",
            caption
          )
        }
      ]
    )
  )
}

#let template(
  title: none,
  subtitle: none,
  abstract: none,
  author: (),
  date: datetime.today(),
  vibe: "tufte",
  fontsize: 11pt,
  toc: false,
  bibliography-file: none,
  doc,
) = {
  
  let fonts = (
    serif: ("ETBembo"),
    sans: ("Gill Sans"),
    mono: ("SF Mono"),
  )

  // page setup with tufte-style margins
  set page(
    paper: "us-letter",
    margin: (y: 1.5in, left: 1.25in, right: 2.75in), // wide right margin for sidenotes
    header: context {
      if here().page() != 1 {
        set text(
          font: fonts.serif, 
          weight: "semibold", 
          size: 8pt, 
          tracking: 1.1pt, 
          number-type: "old-style", 
          number-width: "tabular"
        )
        place(
          right, 
          dy: 1.5em, 
          dx: 5em
        )[
          #if title != none { upper(title) } 
          #h(1em) 
          #text(size: 12pt)[#counter(page).display()]
        ]
      }
    }
  )

  // title block spanning full width including margin
  if title != none or author != none or abstract != none {
    block(
      width: 100% + 5.75in - 1.25in, // span into right margin
      inset: 0pt,
      text(font: fonts.sans, size: 10pt, tracking: 2pt)[
        // title
        #if title != none {
          text(size: 16pt, weight: 400)[#upper(title)]
          if subtitle != none { linebreak(); text(size: 12pt, style: "italic")[#subtitle] }
          linebreak()
        }
        
        // author
        #if author != none {
          author
          linebreak()
        }
        
        // date
        #if date != none {
          // upper(date.display("[month repr:long] [day], [year]"))
          date
          linebreak()
        }
        
        // abstract
        #if abstract != none {
          v(0.8em)
          block(
            inset: (left: 0.25in, right: 2.75in),
            text(tracking: 0pt, size: 9.5pt)[#abstract]
          )
        }
      ]
    )
    
    v(2em)
  }
  
  // table of contents
  if toc {
    block(
      width: 100% + 5.75in - 1.25in,
      inset: (bottom: 2em),
      [
        #set text(font: fonts.sans, size: 9pt)
        #outline(indent: 1em, title: [Contents], depth: 2)
      ]
    )
  }

  // heading configuration
  set heading(numbering: none)
  show heading: it => context {
    let levels = counter(heading).get()
    
    if it.level == 1 {
      // first-level headings
      let is-ack = it.body in ([Acknowledgment], [Acknowledgement])
      set text(
        font: fonts.serif,
        size: if is-ack { 11pt } else { 14pt },
        style: "italic",
        weight: 400
      )
      v(1.5em, weak: true)
      it.body
      v(1.2em, weak: true)
    } else if it.level == 2 {
      // second-level headings
      set par(first-line-indent: 0pt)
      set text(
        font: fonts.serif,
        style: "italic", 
        size: 12pt,
        weight: 400
      )
      v(1.2em, weak: true)
      it.body
      v(0.8em, weak: true)
    } else {
      // third-level and beyond - run-in headings
      set text(font: fonts.serif, style: "italic", weight: 400)
      [_#(it.body):_] + h(0.5em)
    }
  }

  // body text configuration
  set text(
    font: fonts.serif, 
    weight: "regular", 
    size: fontsize, 
    tracking: 0pt, 
    number-type: "old-style", 
    number-width: "tabular",
    fill: rgb("#1f2937")
  )
  
  set par(
    justify: true,
    leading: 0.65em,
    first-line-indent: 1em,
  )

  // enhanced table styling
  set table(
    stroke: (x, y) => {
      if y == 0 { 
        (bottom: 1.2pt + rgb("#374151"))
      } else {
        (bottom: 0.4pt + rgb("#e5e7eb"))
      }
    },
    fill: none,
    inset: (x: 0.6em, y: 0.5em),
  )
  
  show table.cell.where(y: 0): it => {
    text(weight: 600, font: fonts.sans, size: 9pt, it)
  }
  
  show table: it => {
    v(1em, weak: true)
    set text(size: fontsize * 0.9)
    it
    v(0.8em, weak: true)
  }

  // quote styling
  set quote(block: true)
  show quote: it => {
    v(1em, weak: true)
    block(
      inset: (left: 2em, right: 1em, top: 0.8em, bottom: 0.8em),
      [
        #set text(style: "italic", size: fontsize * 0.95)
        #set par(first-line-indent: 0pt)
        #it.body
        
        #if it.attribution != none {
          v(0.5em)
          align(right)[
            #text(
              size: fontsize * 0.85,
              style: "normal", 
              font: fonts.sans,
              [—#it.attribution]
            )
          ]
        }
      ]
    )
    v(1em, weak: true)
  }

  // list styling  
  set list(
    marker: (
      [•], [‣], [◦]
    )
  )
  
  // code styling
  show raw.where(block: true): it => {
    v(1em)
    block(
      fill: rgb("#fafafa"),
      inset: 12pt,
      radius: 3pt,
      width: 100%,
      stroke: 0.5pt + rgb("#e5e7eb"),
      text(
        font: fonts.mono,
        size: fontsize * 0.85,
        it
      )
    )
    v(1em)
  }
  
  show raw.where(block: false): it => {
    box(
      fill: rgb("#f8f9fa"),
      inset: (x: 3pt, y: 1pt),
      radius: 2pt,
      text(
        font: fonts.mono,
        size: fontsize * 0.9,
        fill: rgb("#d63384"),
        it
      )
    )
  }

  // figures and captions
  show figure: set figure.caption(separator: [.#h(0.5em)])
  show figure.caption: set text(
    font: fonts.sans, 
    size: fontsize * 0.85, 
    fill: rgb("#4b5563")
  )
  
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.where(kind: table): set figure(numbering: "I")
  show figure.where(kind: image): set figure(supplement: [Figure], numbering: "1")

  // links and emphasis
  show link: it => text(fill: rgb("#1d4ed8"), it)
  show emph: it => text(style: "italic", it)
  show strong: it => text(weight: 600, it)
  
  // footnotes styled consistently with sidenotes
  show footnote: it => {
    super(text(size: 8pt, fill: rgb("#1d4ed8"))[#it])
  }

  // math equations
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  doc
  
  // bibliography
  if bibliography-file != none {
    v(2em)
    heading(level: 1)[References]
    
    set text(font: fonts.sans, size: fontsize * 0.9)
    set par(justify: false, first-line-indent: -1em, hanging-indent: 1em)
    set bibliography(title: none, style: "chicago-author-date")
    bibliography(bibliography-file)
  }
}

// pandoc integration
#show: doc => template(
$if(title)$
  title: [$title$],
$endif$
$if(subtitle)$
  subtitle: [$subtitle$],
$endif$
$if(author)$
  author: ($for(author)$[$author$]$sep$, $endfor$),
$endif$
$if(date)$
  date: "$date$",
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
$if(toc)$
  toc: $toc$,
$endif$
$if(bibliography-file)$
  bibliography-file: "$bibliography-file$",
$endif$
  doc,
)

$body$