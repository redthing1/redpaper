// double column paper template using style2 core
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
  fontsize: 10pt,
  pagestyle: "double",
  doc,
) = {
  
  let fonts = get_fonts(vibe)
  let adjustments = get_adjustments(vibe, fontsize)
  
  // override spacing for tighter double column layout with paragraph indents
  let adjustments = (..adjustments, spacing: 8pt, leading: 7pt, first-line-indent: 1.2em)
  
  set page(
    paper: "us-letter",
    margin: (top: 1in, bottom: 1in, x: 0.75in),
    numbering: "1",
    columns: 2,
  )
  
  set columns(gutter: 0.75in)
  
  apply_base_styling(fonts, adjustments,
    apply_article_headings(fonts, {
      // for double column layouts, we need to handle the header differently
      // using place with scope: "parent" to span both columns
      if title != none or subtitle != none or author != none or date != none or abstract != none {
        place(
          top + center,
          float: true,
          scope: "parent",
          clearance: 2em,
        )[
          #render_header(title, subtitle, author, date, abstract, fonts)
        ]
      }
      
      doc
    }, heading-sizes: (
      h1: 1.1em,
      h2: 1.05em, 
      h3: 1.0em,
    ), heading-spacing: (
      before: (h1: 1.6em, h2: 1.0em, h3: 1.0em),
      after: (h1: 1.2em, h2: 1.0em, h3: 1.0em)
    ))
  )
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
#place(
  top + center,
  float: true,
  scope: "parent",
  clearance: 1em,
)[
  #outline(
    title: auto,
    depth: $if(toc-depth)$$toc-depth$$else$3$endif$
  )
]
#v(2em)
$endif$

$body$