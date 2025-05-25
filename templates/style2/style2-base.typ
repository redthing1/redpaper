// style2-base.typ - Shared foundation for redpaper style2 templates
// Contains font definitions, styling rules, and common functionality

// --- font vibe definitions ---
// each vibe defines a complete font stack with fallbacks
#let font-vibes = (
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

// get font stack for a vibe with fallback to classic
#let get-fonts(vibe) = {
  font-vibes.at(vibe, default: font-vibes.classic)
}

// --- shared styling functions ---

// apply base text and paragraph styling
#let apply-base-styling(fonts, fontsize) = {
  set text(
    font: fonts.serif,
    size: fontsize,
    lang: "en",
  )
  
  set par(
    justify: true,
    leading: 0.55em,
  )
}

// configure heading styles (takes scale factor for different layouts)
#let apply-heading-styles(fonts, scale: 1.0) = {
  set heading(numbering: "1.1")
  
  show heading: it => {
    // base spacing (adjusted by scale for different layouts)
    let base-space-before = 0.8em * scale
    let base-space-after = 0.4em * scale
    
    v(base-space-before, weak: true)
    
    if it.level == 1 {
      text(
        size: (1.3em * scale),
        weight: 600,  // semibold
        font: fonts.serif,
        it
      )
    } else if it.level == 2 {
      text(
        size: (1.1em * scale), 
        weight: 500,  // medium
        font: fonts.serif,
        it
      )
    } else {
      text(
        size: (1em * scale),
        style: "italic",
        font: fonts.serif,
        it
      )
    }
    
    v(base-space-after, weak: true)
  }
}

// configure code block styling 
#let apply-code-styles(fonts, scale: 1.0) = {
  // block code
  show raw.where(block: true): it => {
    block(
      fill: luma(250),
      inset: (8pt * scale),
      radius: (4pt * scale),
      width: 100%,
      text(
        font: fonts.mono,
        size: (0.85em * scale),
        it
      )
    )
  }
  
  // inline code  
  show raw.where(block: false): it => {
    box(
      fill: luma(240),
      inset: (x: 3pt * scale, y: 0pt),
      outset: (y: 3pt * scale),
      radius: (2pt * scale),
      text(
        font: fonts.mono,
        size: (0.9em * scale),
        it
      )
    )
  }
}

// apply consistent text styling (links, emphasis, etc.)
#let apply-text-styles() = {
  // link styling
  show link: it => text(
    fill: rgb("#0066cc"),
    it
  )
  
  // emphasis styling  
  show emph: it => text(style: "italic", it)
  show strong: it => text(weight: "bold", it)
}

// create title block content (used differently in single vs double column)
#let create-title-block(title, authors, date, fonts, title-size: 1.8em) = {
  align(center)[
    #if title != none {
      text(
        size: title-size,
        weight: "bold", 
        font: fonts.serif,
        title
      )
    }
    
    #if authors != none and authors.len() > 0 {
      v(0.5em)
      text(
        size: (title-size * 0.6),
        font: fonts.serif,
        authors.join(", ")
      )
    }
    
    #if date != none {
      v(0.3em)
      text(
        size: (title-size * 0.55),
        font: fonts.serif,
        date
      )
    }
  ]
}

// create abstract block
#let create-abstract-block(abstract, fonts, text-size: 0.95em) = {
  if abstract != none {
    block(
      inset: (x: 2em),
      [
        #align(center, text(weight: "bold", "Abstract"))
        #v(0.5em)
        #text(size: text-size, abstract)
      ]
    )
  }
}

// apply all shared styling in correct order
#let apply-all-shared-styles(fonts, fontsize, layout-scale: 1.0) = {
  apply-base-styling(fonts, fontsize)
  apply-heading-styles(fonts, scale: layout-scale)
  apply-code-styles(fonts, scale: layout-scale)  
  apply-text-styles()
}