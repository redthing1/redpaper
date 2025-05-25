---
title: "Migrating from LaTeX to Typst"
subtitle: "A Beautiful Typography Journey"
author: "Redpaper Team"
date: "May 2025"
abstract: |
  This document demonstrates the successful migration from LaTeX-based document 
  generation to Typst, showcasing improved typography, faster compilation, and 
  cleaner template syntax. We evaluate multiple font combinations ("vibes") 
  and layout options while maintaining the aesthetic quality that made our 
  original LaTeX templates successful.
vibe: "classic"
---

# Introduction

Welcome to the future of document typesetting! This document serves as both a **demonstration** and a *test case* for our new Typst-based templates that replace the old LaTeX system.

The migration brings several immediate benefits:

- **Faster compilation** (5-20x speed improvement)
- **Cleaner template syntax** (readable, no escaping hell)
- **Better error messages** (actually helpful!)
- **Modern font handling** (Unicode support, fallbacks)
- **Integrated scripting** (no external tools needed)

Let's explore what these templates can do.

## Typography Showcase

### Font Vibes

Our template system supports multiple font "vibes" that create distinct personalities:

**Classic** (Default)
: Traditional academic style using Alegreya, Fira Sans, and Iosevka

**Professional** 
: Business-oriented design with Palatino Nova and Helvetica Now Text

**Artistic**
: Creative elegance featuring Adobe Jenson Pro and Messina Sans

**Forward**
: Modern progressive look with Austera Text and Native

**Orthographic**
: Emphasis on readability using FS Ostro

**Alternate**
: Sophisticated alternative with EB Garamond

### Text Formatting

We support all the standard formatting you'd expect:

- *Italic text* for emphasis
- **Bold text** for strong emphasis  
- `Inline code` with proper monospace fonts
- [Links](https://typst.app/docs/) with appropriate styling
- ~~Strikethrough~~ when needed

### Code Blocks

Here's how code appears in our templates:

```python
def beautiful_typography():
    """Typst makes beautiful documents easy."""
    fonts = {
        'serif': 'Alegreya',
        'sans': 'Fira Sans', 
        'mono': 'Iosevka'
    }
    return compile_to_pdf(fonts)

# function calls are clean and readable
result = beautiful_typography()
print(f"Generated PDF with {result.font_combinations} font combos")
```

The syntax highlighting and monospace rendering should work perfectly across all vibes.

## Mathematical Content

One of Typst's major strengths is mathematical typesetting. Here are some examples:

### Inline Mathematics

The famous equation $E = mc^2$ demonstrates inline math rendering. We can also have more complex expressions like $\sum_{i=1}^{n} x_i^2$ or $\int_0^\infty e^{-x} dx = 1$.

### Display Mathematics

More complex equations deserve their own space:

$$
\frac{\partial^2 u}{\partial t^2} = c^2 \nabla^2 u
$$

And here's the quadratic formula that everyone knows:

$$
x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}
$$

### Mathematical Expressions

Greek letters work beautifully: α, β, γ, δ, ε, η, θ, κ, λ, μ, ρ, σ, τ, φ, ω.

Complex expressions with subscripts and superscripts:
$$
H_\psi = -\frac{\hbar^2}{2m} \nabla^2 + V(x)
$$

## Layout Features

### Lists and Structure

Numbered lists work as expected:

1. **First major point** with nested information
   - Sub-point with details
   - Another important sub-point
2. **Second major point** 
   - More nested content
   - Cross-references work well
3. **Final point** that ties everything together

Bullet lists are equally well-formatted:

- Primary bullet point
  - Nested secondary point
  - Another secondary point
- Another primary point
- Final primary bullet

### Blockquotes

> This is a blockquote that demonstrates how quoted text appears in our templates. The typography should be clearly distinguished from body text while maintaining readability.
>
> Multiple paragraph blockquotes are also supported and should render with appropriate spacing.

## Performance Comparison

| Metric | LaTeX | Typst | Improvement |
|--------|-------|-------|-------------|
| Compile Time | 12s | 0.8s | **15x faster** |
| Template LOC | 247 | 89 | **64% reduction** |
| Error Clarity | Poor | Excellent | **Much better** |
| Font Setup | Complex | Simple | **Much easier** |

## Testing Different Layouts

This document should work well in both single and double column layouts:

### Single Column Layout
- Better for reading flow
- Ideal for longer paragraphs
- Great for documents with wide tables or code
- Standard academic paper format

### Double Column Layout  
- More efficient space usage
- Professional journal appearance
- Better for shorter sections
- Excellent for technical documentation

## Advanced Features

### Custom Styling

Our templates support advanced customization through Typst's clean syntax. Unlike LaTeX's macro hell, Typst uses readable functions and parameters.

### Font Fallbacks

The template includes intelligent font fallback handling. If a specified font isn't available, the system gracefully degrades to ensure your document always renders properly.

### Responsive Design

The templates automatically adjust spacing, margins, and typography based on the chosen layout (single vs. double column) and font vibe.

## Conclusion

The migration from LaTeX to Typst represents a significant step forward in document generation quality and developer experience. The templates maintain all the typographic excellence of our original LaTeX system while providing:

- **Dramatically faster iteration** during development
- **More maintainable template code** 
- **Better error handling and debugging**
- **Cleaner integration with modern workflows**

The future of beautiful document generation is here, and it's built on Typst.

## Appendix: Technical Details

### Font Requirements

To use all vibes, ensure these fonts are installed:

**Serif Fonts:**
- Alegreya, EB Garamond, Austera Text
- Palatino Nova, FS Ostro, Adobe Jenson Pro

**Sans Serif Fonts:**  
- Fira Sans, Messina Sans, Helvetica Now Text

**Monospace Fonts:**
- Iosevka, Inconsolata, Native
- Source Code Pro, Basis Grotesque Mono Pro

### Build Commands

```bash
# Test different vibes
./build.sh document.md classic single
./build.sh document.md professional double  
./build.sh document.md artistic single

# Direct pandoc usage
pandoc document.md --pdf-engine=typst \
  --template=style2-single.typ \
  -V vibe=artistic -o output.pdf
```

This completes our comprehensive test of the new Typst template system!