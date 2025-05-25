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

#let conf(
  title: none,
  subtitle: none, 
  author: none,
  date: none,
  abstract: none,
  vibe: "classic",
  fontsize: 11pt,
  pagestyle: "single",
  doc,
) = {
  
  let font-vibes = (
    classic: (
      serif: "Alegreya",
      sans: "Fira Sans",
      mono: "Iosevka",
    ),
    alternate: (
      serif: "EB Garamond",
      sans: "Fira Sans",
      mono: "Inconsolata",
    ),
    artistic: (
      serif: "Adobe Jenson Pro",
      sans: "Messina Sans",
      mono: "Basis Grotesque Mono Pro",
    ),
  )
  
  let fonts = font-vibes.at(vibe, default: font-vibes.classic)
  
  set page(
    paper: "us-letter",
    margin: 1in,
    numbering: "1",
  )
  
  let base-font-size = fontsize

  // set adjustments based on vibe
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
  )
  let adjustments = adjustment_config.at(vibe, default: adjustment_config.classic)
  
  set text(
    font: fonts.serif,
    size: adjustments.font-size,
    lang: "en",
  )
  
  set par(
    justify: true,
    leading: adjustments.leading,
    spacing: adjustments.spacing,
    first-line-indent: 0pt,
  )
  
  set heading(numbering: "1.1")
  
  show heading: it => {
    v(if it.level == 1 { 3em } else { 1.4em }, weak: true)
    
    if it.level == 1 {
      text(
        size: 1.3em,
        weight: 400,
        font: fonts.serif,
        it
      )
    } else if it.level == 2 {
      text(
        size: 1.15em,
        weight: 400,
        font: fonts.serif,
        it
      )
    } else {
      text(
        size: 1.05em,
        style: "italic",
        weight: 400,
        font: fonts.serif,
        it
      )
    }
    
    v(1.4em, weak: true)
  }
  
  // clean, modern table styling
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
  
  // style header row cells with subtle emphasis
  show table.cell.where(y: 0): it => {
    text(weight: 600, fill: rgb("#1f2937"), it)
  }
  
  // add spacing around tables
  show table: it => {
    v(1.2em, weak: true)
    set text(size: adjustments.font-size * 0.95)
    it
    v(1em, weak: true)
  }
  
  // proper quote styling using built-in quote element
  set quote(block: true)
  
  show quote: it => {
    v(1em, weak: true)
    block(
      inset: (left: 1.5em, top: 0.8em, bottom: 0.8em, right: 0.5em),
      stroke: (left: 3pt + rgb("#e5e7eb")),
      fill: rgb("#fafafa"),
      radius: (right: 3pt),
      width: 100%,
      [
        #set text(style: "italic", fill: rgb("#4b5563"))
        #set par(spacing: 0.6em)
        
        #it.body
        
        #if it.attribution != none {
          v(0.4em)
          align(right)[
            #text(
              size: 0.9em, 
              style: "normal",
              weight: 500,
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
    // indent: 1em,
    // body-indent: 0.5em,
    spacing: auto,
    marker: (
      text(fill: rgb("#6b7280"), "•"),
      text(fill: rgb("#6b7280"), "‣"), 
      text(fill: rgb("#6b7280"), "◦"),
    )
  )
  
  // // math display
  // show math.equation.where(block: true): it => {
  //   v(1.2em, weak: true)
  //   block(
  //     width: 100%,
  //     inset: (x: 2em, y: 1em),
  //     align(center, it)
  //   )
  //   v(1.2em, weak: true)
  // }
  
  // footnote styling
  show footnote: it => {
    super(
      text(
        fill: rgb("#1d4ed8"), 
        size: 0.75em,
        it
      )
    )
  }
  
  // definition list enhancement
  show terms: it => {
    v(0.8em, weak: true)
    it.children.map(child => [
      #text(
        weight: 500, 
        fill: rgb("#1f2937"), 
        size: 1.02em,
        child.term
      )
      #block(
        inset: (left: 1.8em, top: 0.2em, bottom: 0.6em)
      )[
        #set text(fill: rgb("#374151"))
        #child.description
      ]
    ]).join()
    v(0.8em, weak: true)
  }
  
  show raw.where(block: true): it => {
    v(1em)
    block(
      fill: luma(250),
      inset: 14pt,
      radius: 4pt,
      width: 100%,
      text(
        font: fonts.mono,
        size: 0.9em,
        it
      )
    )
    v(1em)
  }
  
  show raw.where(block: false): it => {
    box(
      fill: luma(240),
      inset: (x: 4pt),
      outset: (y: 3pt),
      radius: 3pt,
      text(
        font: fonts.mono,
        size: 1em,
        it
      )
    )
  }
  
  show link: it => text(fill: rgb("#1d4ed8"), it)
  show emph: it => text(style: "italic", it)
  show strong: it => text(weight: 450, it)
  
  // compact document header
  if title != none or subtitle != none or author != none or date != none {
    
    if title != none {
      align(center)[
        #block(
          width: 85%,
          text(
            size: 1.8em,
            weight: 300,
            font: fonts.serif,
            title
          )
        )
      ]
      v(0.8em)
    }
    
    if subtitle != none {
      align(center)[
        #block(
          width: 80%,
          text(
            size: 1.2em,
            style: "italic",
            weight: 300,
            font: fonts.serif,
            subtitle  
          )
        )
      ]
      v(0.6em)
    }
    
    if author != none or date != none {
      align(center)[
        #if author != none {
          text(
            size: 1em,
            weight: 300,
            font: fonts.serif,
            author
          )
        }
        
        #if date != none {
          text(
            size: 1em,
            weight: 400,
            font: fonts.serif,
            date
          )
        }
      ]
      v(0.6em)
    }
    
    align(center)[
      #line(length: 25%, stroke: 0.5pt + luma(160))
    ]
  }
  
  if abstract != none {
    align(center)[
      #block(
        width: 80%,
        inset: (x: 0em, y: 0.6em),
        [
          #text(
            size: 1em,
            weight: 400,
            font: fonts.serif,
            "Abstract"
          )
          #v(0.6em)
          #text(
            size: 0.95em,
            style: "italic",
            abstract
          )
        ]
      )
    ]

    v(0.6em)
  }
  
  doc
}

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
  doc,
)

$if(toc)$
#v(1em)
#outline(
  title: auto,
  depth: $if(toc-depth)$$toc-depth$$else$3$endif$
)
#v(2em)
$endif$

$body$