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
  
  apply_common_styling(fonts, adjustments, {
    show heading.where(level: 1): it => {
      // chapter titles start on new page
      pagebreak(weak: true, to: "odd")
      v(3em)
      
      block(width: 100%)[
        #set align(left)
        #text(
          size: 2.2em,
          weight: 300,
          font: fonts.serif,
          fill: rgb("#1f2937"),
          it
        )
      ]
      v(2em)
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

$if(toc)$
#pagebreak()
#v(2em)
#align(center)[
  #text(
    size: 1.4em,
    weight: 400,
    "Contents"
  )
]
#v(1.5em)
#outline(
  title: none,
  depth: $if(toc-depth)$$toc-depth$$else$2$endif$
)
$endif$

$body$