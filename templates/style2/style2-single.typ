// single column handout template using style2 core
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
  pagestyle: "single",
  doc,
) = {
  
  let fonts = get_fonts(vibe)
  let adjustments = get_adjustments(vibe, fontsize)
  
  set page(
    paper: "us-letter",
    margin: 1in,
    numbering: "1",
  )
  
  apply_base_styling(fonts, adjustments,
    apply_article_headings(fonts, {
      render_header(title, subtitle, author, date, abstract, fonts)
      doc
    })
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
#outline(
  title: auto,
  depth: $if(toc-depth)$$toc-depth$$else$3$endif$
)
#v(2em)
$endif$

$body$