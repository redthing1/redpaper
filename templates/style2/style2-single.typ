// style2-single-clean.typ - beautiful single column template for internal documents

#let horizontalrule = line(start: (25%,0%), end: (75%,0%))

#show terms: it => it.children.map(child => [
  #text(weight: 400, fill: rgb("#374151"), child.term)
  #block(inset: (left: 1.5em, top: -0.4em))[#child.description]
]).join()

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
    forward: (
      serif: "Austera Text",
      sans: "Messina Sans",
      mono: "Native",
    ),
    professional: (
      serif: "Palatino Nova",
      sans: "Helvetica Now Text",
      mono: "Source Code Pro",
    ),
    orthographic: (
      serif: "FS Ostro",
      sans: "Messina Sans", 
      mono: "Native",
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
  
  set text(
    font: fonts.serif,
    size: fontsize,
    lang: "en",
  )
  
  set par(
    justify: true,
    leading: 0.7em,
    spacing: 0.8em,
    first-line-indent: 0pt,
  )
  
  set heading(numbering: "1.1")
  
  show heading: it => {
    v(if it.level == 1 { 1.4em } else { 1em }, weak: true)
    
    if it.level == 1 {
      text(
        size: 1.3em,
        weight: 400,
        font: fonts.serif,
        smallcaps(it.body),
      )
    } else if it.level == 2 {
      text(
        size: 1.15em,
        style: "italic",
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
    
    v(0.7em, weak: true)
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
      fill: luma(248),
      inset: (x: 4pt, y: 2pt),
      outset: (y: 3pt),
      radius: 3pt,
      text(
        font: fonts.mono,
        size: 0.92em,
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