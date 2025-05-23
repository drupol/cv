#import "metadata.typ": *
#import "@preview/fontawesome:0.5.0": *

#let languageItem(
  lang: "",
  level: "",
  comment: "",
) = {
  block(
    grid(
      columns: (1fr, 1fr),
      align: (left, right),
    )[
      #text(weight: "bold", lang)
      #text(fill: black.lighten(75%), box(width: 1fr, repeat[.]))
    ][
      #text(fill: black.lighten(75%), box(width: 1fr, repeat[.]))
      #text(fill: black.lighten(0%))[#level]
      #text(fill: black.lighten(0%))[#comment]
    ],
  )
}

#let educationEntry(
  title: none,
  school: none,
  date: none,
  type: none,
  grade: none,
  body,
) = {
  set text(size: font-defaults.footnotesize)
  block(
    grid(
      columns: (auto, auto),
      column-gutter: 1em,
      row-gutter: .5em,
      {
        date
      },
      grid(
        columns: (1fr, auto),
        column-gutter: 1em,
        align: (left, right),
        text(weight: "bold", title), text(fill: black.lighten(65%))[#school],
      ),
      ..if grade != none {
        (text(fill: black.lighten(70%))[#grade],)
      },
      ..if body != [] {
        (body,)
      },
    ),
  )
}

#let jobEntry(
  title: none,
  company: none,
  location: none,
  date: none,
  type: none,
  tags: (),
  body,
) = {
  set text(size: font-defaults.footnotesize)
  grid(
    columns: (5fr, 35fr),
    row-gutter: 0.5em,
    column-gutter: 1em,
    align: (left, left),
    ..(
      ..if date != none { (date,) },
      ..if title != none and company != none {
        (
          grid(
            columns: (1fr, 1fr),
            align: (left, right),
          )[
            #text(weight: "bold", title)
            #text(fill: black.lighten(75%), box(width: 1fr, repeat[.]))
          ][
            #text(fill: black.lighten(75%), box(width: 1fr, repeat[.]))
            #text(fill: black.lighten(70%))[#company]
          ],
        )
      },
      {
        set text(fill: black.lighten(70%))
        grid(
          row-gutter: .5em,
          type, location
        )
      },
      {
        body
        {
          set text(font: "New Computer Modern Mono", fill: black.lighten(60%))
          grid(columns: 1fr, tags.join(" / "))
        }
      },
    )
  )
}

#let linkItem(body, icon: "") = {
  block(
    grid(
      columns: (auto, auto),
      column-gutter: .3em,
      align: horizon,
      box(width: 2em, height: 2em, fill: black)[
        #{
          set align(center + horizon)
          fa-icon(icon, fill: white)
        }
      ],
      body,
    ),
  )
}

#let customBox(
  body,
  title: "",
) = {
  grid(rows: 2, row-gutter: .5em)[
    #{
      block(fill: black, inset: .3em)[
        #text(fill: white, size: font.large)[#upper(title)]
      ]
    }
  ][
    #v(.35em)
    #body
  ]
}

#let featureBar(
  title: "Skills",
  value: 100%,
) = {
  {
    grid(
      columns: (1fr, 1fr),
      column-gutter: 1em,
      align: horizon,
      align(right)[#title],
      line(stroke: .75em + blue.darken(30%), length: value),
    )
  }
}

#let LaTeX = {
  [L]
  box(
    move(
      dx: -4.2pt,
      dy: -1.2pt,
      box(scale(65%)[A]),
    ),
  )
  box(
    move(
      dx: -5.7pt,
      dy: 0pt,
      [T],
    ),
  )
  box(
    move(
      dx: -7.0pt,
      dy: 2.7pt,
      box(scale(100%)[E]),
    ),
  )
  box(
    move(
      dx: -8.0pt,
      dy: 0pt,
      [X],
    ),
  )
  h(-8.0pt)
}
