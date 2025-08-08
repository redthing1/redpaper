// book/booklet template with title page, contents, and chapters using style2 core
#import "./templates/style2/style2-core.typ": *

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
  pagestyle: "book",
  doc,
) = {
  
  let fonts = get_fonts(vibe)
  let adjustments = get_adjustments(vibe, fontsize)
  
  set page(
    paper: "us-letter",
    margin: (inside: 1.25in, outside: 1in, y: 1in),
    binding: left,
    numbering: "1",
  )
  
  // custom book-style heading formatting  
  set heading(numbering: "1.1")
  
  show heading.where(level: 1): it => {
    // chapter titles start on new page
    pagebreak(weak: true)
    
    block(width: 100%, above: 1.5em, below: 1.2em)[
      #set align(left)
      #text(
        size: 1.6em,
        weight: 400,
        font: fonts.serif,
        fill: rgb("#1f2937"),
        it
      )
    ]
  }
  
  show heading.where(level: 2): it => {
    v(1.8em, weak: true)
    text(
      size: 1.25em,
      weight: 400,
      font: fonts.serif,
      it
    )
    v(0.8em, weak: true)
  }
  
  show heading.where(level: 3): it => {
    v(1.4em, weak: true)
    text(
      size: 1.1em,
      weight: 400,
      style: "italic",
      font: fonts.serif,
      it.body
    )
    v(0.6em, weak: true)
  }
  
  // title page
  if title != none {
    page[
      #set align(center + horizon)
      
      #if title != none {
        text(
          size: 2.8em,
          weight: 300,
          font: fonts.serif,
          fill: rgb("#1f2937"),
          title
        )
        v(1em)
      }
      
      #if subtitle != none {
        text(
          size: 1.6em,
          style: "italic",
          weight: 300,
          font: fonts.serif,
          fill: rgb("#374151"),
          subtitle
        )
        v(2em)
      }
      
      #if author != none {
        text(
          size: 1.3em,
          weight: 400,
          font: fonts.serif,
          fill: rgb("#4b5563"),
          author
        )
        v(0.5em)
      }
      
      #if date != none {
        text(
          size: 1em,
          weight: 300,
          font: fonts.serif,
          fill: rgb("#6b7280"),
          date
        )
      }
    ]
  }
  
  // abstract page (if provided)
  if abstract != none {
    pagebreak()
    v(2em)
    align(center)[
      #text(
        size: 1.4em,
        weight: 400,
        font: fonts.serif,
        "Abstract"
      )
    ]
    v(1.5em)
    
    block(
      width: 85%,
      text(
        size: 1em,
        style: "italic",
        fill: rgb("#374151"),
        abstract
      )
    )
  }
  
  apply_base_styling(fonts, adjustments, {
    // table of contents (always included for books)
    pagebreak()
    v(2em)
    align(center)[
      #text(
        size: 1.4em,
        weight: 400,
        font: fonts.serif,
        "Contents"
      )
    ]
    v(1.5em)
    outline(
      title: none,
      depth: 2
    )
    pagebreak()
    
    doc
  })
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


$body$