#import "@preview/fontawesome:0.4.0": *
#import "common/metadata.typ": *
#import "common/lib.typ": *

#let resume(
  firstname: "",
  lastname: "",
  body,
) = {
  // --- Page configuration ---
  set page(
    margin: page-margin,
    numbering: "1",
    number-align: center,
    paper: "a4",
    footer: ""
  )

  // --- Typography ---
  set text(
    font: body-font,
    size: font.normal,
    lang: "en",
    hyphenate: false,
  )

  // --- Paragraphs ---
  // Source: https://typst.app/docs/guides/guide-for-latex-users/
  set par(justify: true)
  show par: set block(spacing: .75em)

  // --- Links ---
  show link: it => {
    underline(it, stroke: .2pt + rgb("#000000").lighten(65%))
  }

  {
    grid(
      columns: (1fr, 3fr),
      align: (left, right),
    )[
      #text(size: 3em, weight: "bold")[#firstname]\
      #text(size: 3em, weight: "bold")[#lastname]\
      #text(size: 1.12em)[#subtitle]\
    ][
      #{
        grid(columns: 3, rows: 2, column-gutter: 1em, row-gutter: .5em, align: left)[
          #linkItem(icon: "map-pin")[#link("https://www.openstreetmap.org//#map=15/50.59690/4.32280")[Nivelles, Belgium]]
        ][
          #linkItem(icon: "github")[#link("https://github.com/drupol")[github.com/drupol]]
        ][
          #linkItem(icon: "envelope")[#link("mailto:pol.dellaiera@protonmail.com")[pol.dellaiera\@protonmail.com]]
        ][
          #linkItem(icon: "globe")[#link("https://not-a-number.io")[not-a-number.io]]
        ][
          #linkItem(icon: "github")[#link("https://github.com/loophp")[github.com/loophp]]
        ][
          #linkItem(icon: "mastodon")[#link("https://mathstodon.xyz/@Pol")[\@pol\@mathstodon.xyz]]
        ]
      }
    ]

    customBox(title: [About])[
      #grid(
        columns: (1fr, 1fr)
      )[
        Since beginning my web development journey in 2010, I have acquired a wealth
        of experience across diverse environments, including innovative start-ups
        and established consultancies.
        A highly motivated, self-taught professional, I am passionate about solving
        intricate problems by implementing elegant, streamlined solutions.

        My insatiable curiosity and meticulous nature have made me a perpetual
        learner, constantly striving to expand my knowledge.

        I take great satisfaction in creating simple, natural, and efficient
        solutions that harmoniously balance aesthetics and functionality.
      ][
        #box(inset: (left: 2em))[
          #featureBar(title: "Linux/NixOS", value: 97%)
          #featureBar(title: "Object Oriented Programming", value: 90%)
          #featureBar(title: "PHP/Python", value: 87%)
          #featureBar(title: "Functional Programming", value: 85%)
          #featureBar(title: "Git/Jujutsu", value: 85%)
          #featureBar(title: "Algorithm", value: 85%)
          #featureBar(title: "Docker", value: 75%)
          #featureBar(title: "Typst", value: 70%)
          #featureBar(title: "LaTeX", value: 65%)
        ]
      ]
    ]

    customBox(title: [Experience])[
      #jobEntry(
        title: "Senior Application Architect",
        company: [#link("https://ec.europa.eu")[European Commission]],
        location: "Bruxelles",
        type: "Full time",
        date: "6/2024 -- present",
        tags: (
          link("https://en.wikipedia.org/wiki/Python_(programming_language)")[Python],
          link("https://en.wikipedia.org/wiki/MongoDB")[MongoDB],
          link("https://en.wikipedia.org/wiki/Nix_(package_manager)")[Nix],
          link("https://en.wikipedia.org/wiki/Git")[Git],
          link("https://github.com/martinvonz/jj")[Jujutsu],
          link("https://en.wikipedia.org/wiki/Infrastructure_as_code")[IAC],
        ),
      )[
        Hired on behalf of a consultancy company, working at
        #link("https://ec.europa.eu/info/departments/informatics_en")[Digit B.4] (#emph[Software Engineering Capabilities]).
        In this role, I am part of a team of developers, responsible for
        developing #emph[GPT\@EC], an internal AI chatbot application based on
        GPT technology. My primary focus is on designing and building a
        scalable, robust solution, ensuring optimal performance, security, and
        integration within the European Commission's ecosystem.
      ]

      #jobEntry(
        title: "Application Architect",
        company: [#link("https://ec.europa.eu")[European Commission]],
        location: "Bruxelles",
        type: "Full time",
        date: "7/2019 -- 6/2024",
        tags: (
          link("https://en.wikipedia.org/wiki/Nix_(package_manager)")[Nix],
          link("https://symfony.com/")[Symfony],
          link("https://www.doctrine-project.org/")[Doctrine],
          link("https://api-platform.com/")[API Platform],
          link("https://en.wikipedia.org/wiki/Oracle_Database")[Oracle],
          link("https://en.wikipedia.org/wiki/Docker_(software)")[Docker],
          link("https://en.wikipedia.org/wiki/Infrastructure_as_code")[IAC],
        ),
      )[
        Hired on behalf of a consultancy company, working at
        #link("https://ec.europa.eu/info/departments/informatics_en")[Digit B.4] (#emph[Software Engineering Capabilities]),
        where I work in the Developer's Journey team. In this role, I guide teams and clients
        through the migration process from ColdFusion to PHP. Additionally, I design and implement authentication libraries
        solutions and the necessary development infrastructure for multiple teams, with
        a focus on creating reproducible and ephemeral development environments based on Nix.
      ]

      #jobEntry(date: [#text(
          size: font-defaults.footnotesize,
          fill: black.lighten(75%),
        )[Before 2019]])[
        #{
          set text(size: font-defaults.footnotesize, fill: black.lighten(75%))
          [This is the public and short version of my CV. Please ask for the full
            version by sending me an email.]
        }
      ]
    ]

    grid(
      columns: (1fr, 1fr),
      column-gutter: 1em,
    )[
      #customBox(title: [Education])[
        #educationEntry(
          title: "MSc Computer Science",
          school: [#link("https://web.umons.ac.be")[University of Mons]],
          type: "Full time",
          grade: [Cum Laude],
          date: "2021 -- 2024",
        )[
          Thesis: #link("https://doi.org/10.5281/zenodo.12666898")["Reproducibility in Software Engineering"]
        ]

        #educationEntry(
          title: "BSc Computer Science",
          school: [#link("https://www.heh.be")[Haute Ecoles en Hainaut]],
          type: "Full time",
          grade: [Cum Laude],
          date: "2001 -- 2005",
        )[
          IT and systems, specialisation in network and telecommunications
        ]

        #educationEntry(
          title: "Music theory / Piano",
          school: [#link("https://academiedenivelles.be")[Académie de musique de Nivelles]],
          type: "Full time",
          date: "2018 -- 2021",
        )[]
      ]
    ][
      #customBox(title: [Certificates])[
        #educationEntry(
          title: "Blockchain: Understanding Its Uses and Implications",
          school: [#link("https://courses.edx.org/certificates/01fdb9d9242546e8bc45153468dfd785")[The Linux Foundation]],
          type: "Full time",
          date: "01/2020",
        )[]

        #educationEntry(
          title: "Acquia Certified Developer",
          school: [#link("https://certification.acquia.com/user/249")[Acquia]],
          type: "Full time",
          date: "09/2015",
        )[]

        #educationEntry(
          title: "Acquia Certified Back End Specialist",
          school: [#link("https://certification.acquia.com/user/249")[Acquia]],
          type: "Full time",
          date: "09/2015",
        )[]
      ]
    ]

    grid(
      columns: (1fr, 2fr, 1fr),
      column-gutter: 1em,
    )[
      #customBox(title: [Languages])[
        - #languageItem(lang: "French", level: "native")
        - #languageItem(lang: "English", level: "B2")
        - #languageItem(lang: "Italian", level: "A2")
        - #languageItem(lang: "Dutch", level: "A2")
      ]
    ][
      #customBox(title: [Hobbies])[
        Besides my work and the geek stuff, I’m currently fulfilling a childhood dream, I’m learning music and piano!
        I love photography and I learned by myself most of the secrets of a reflex camera, just for fun.
        I swim a lot and I also really like riding my mountain bike.
      ]
    ][
      #customBox(title: [Non Profit])[
        Contributor in many open-source projects. Official maintainer of the #link("https://nixos.org")[NixOS Linux distribution].

        I am also an OpenStreetMap user and contributor.
      ]
    ]

    customBox(title: [Favorite quotes])[
      - Simplicity is the ultimate sophistication. - Leonardo da Vinci
      - Only when the last tree has died and the last river been poisoned and the last fish been caught will we realize we cannot eat money. - Indian author
      - We may regard the present state of the universe as the effect of its past and the cause of its future. An intellect which at a certain moment would know all forces that set nature in motion, and all positions of all items of which nature is composed, if this intellect were also vast enough to submit these data to analysis, it would embrace in a single formula the movements of the greatest bodies of the universe and those of the tiniest atom; for such an intellect nothing would be uncertain and the future just like the past would be present before its eyes. - Pierre Simon Laplace
    ]

  }
}
