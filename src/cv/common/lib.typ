#import "metadata.typ": *
#import "@preview/fontawesome:0.4.0": *

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
      #box(width: 1fr, repeat[.])
    ][
      #box(width: 1fr, repeat[.])
      #text(fill: black.lighten(70%))[#level]
      #text(fill: black.lighten(70%))[#comment]
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
        columns: (1fr, 1fr),
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
  grid(
    columns: (auto, 1fr),
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
            #text(fill: black.lighten(90%), box(width: 1fr, repeat[.]))
          ][
            #text(fill: black.lighten(90%), box(width: 1fr, repeat[.]))
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
  grid(rows: 2, row-gutter: 0em)[
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
    block()[
      #grid(
        columns: (1fr, 1fr),
        column-gutter: 1em,
        align: horizon,
        align(right)[#title],
        line(stroke: .75em + blue.darken(30%), length: value),
      )
    ]
  }
}
