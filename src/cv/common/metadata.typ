// Enter your thesis data here:
#let title = "Reproducibility in Software Engineering"
#let subtitle = "Research, analysis, development"
#let doi = "10.5281/zenodo.12666898"
#let university = "University of Mons"
#let faculty = "Faculty of Sciences"
#let degree = "Master"
#let program = "Computer Science"
#let view = degree + "'s Thesis in " + program
#let advisors = none
#let author = "Pol Dellaiera"
#let authorOrcId = "0009-0008-7972-7160"
#let startDate = "2023 - 2024"
#let submissionDate = "12 June 2024"
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
