// Enter your thesis data here:
#let subtitle = "Research, analysis, development"
#let body-font = "Roboto"
#let sans-font = "New Computer Modern Sans"
#let page-margin = (left: 5mm, right: 5mm, top: 5mm, bottom: 5mm,)
#let rev = if "rev" in sys.inputs {
  sys.inputs.rev
} else {
  ""
}
#let shortRev = if "shortRev" in sys.inputs {
  sys.inputs.shortRev
} else {
  ""
}
#let builddate = if "builddate" in sys.inputs {
  sys.inputs.builddate
} else {
  ""
}

// Default font sizes from original LaTeX style file.
#let font-defaults = (
  tiny: 6pt,
  scriptsize: 7pt,
  footnotesize: 9pt,
  small: 9pt,
  normalsize: 10pt,
  large: 12pt,
  Large: 14pt,
  LARGE: 17pt,
  huge: 20pt,
  Huge: 25pt,
)

#let font = (
  Large: font-defaults.Large + 0.4pt,  // Actual font size.
  footnote: font-defaults.footnotesize,
  large: font-defaults.large,
  small: font-defaults.small,
  normal: font-defaults.normalsize,
  script: font-defaults.scriptsize,
)
