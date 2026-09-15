# jonleithe.no Project History

This file records durable decisions and milestones from work on the website. It
contains concise summaries rather than verbatim conversation transcripts. Add
new entries at the top.

## 2026-09-12 — Automated Academy notes publishing

- Made the website build regenerate the Academy's Quarto HTML artifact, then
  synchronize it into Hugo's `public/notes/` directory.
- Enabled the "Engineering Notes" menu item, which links to the generated
  subsite at `/notes/`.
- As a result, `make deploy` now publishes the current Academy notes together
  with the Hugo site, without duplicating Markdown sources between repositories.

## 2026-07-31 — Defined the Academy notes publishing boundary

- Established that `project-polaris-academy` is the source of truth for academic
  and engineering notes, Quarto configuration, PDF generation, and generated
  notes HTML.
- Established that `jonleithe.no` owns the Hugo site, final website assembly,
  navigation, and deployment to One.com.
- Chose generated-artifact integration instead of copying or mounting Academy
  Markdown sources into Hugo.
- Planned to publish the Quarto output beneath `/notes/`, with Hugo's
  "Engineering Notes" menu item linking there.
- Agreed that the website build should eventually invoke the Academy's
  `make site` target and place its stable `build/site/` artifact in
  `public/notes/`.
- Documented the repository boundary, validation expectations, and deployment
  safeguards in `AGENTS.md`.
- Added `AUTHOR.md` and this project history so future repository sessions begin
  with the relevant personal and architectural context.

## 2026-07-31 — Adopted the Academy Make interface

- Agreed on explicit single-note rendering with
  `make note NOTE=linear-algebra/<filename>.md`.
- Added Academy targets for `help`, individual notes, all configured notes,
  combined Linear Algebra, the complete book, HTML output, preview, and cleanup.
- Kept the website integration separate until the Quarto site structure and
  output path are stable.

## 2026-07-29 — Added One.com deployment workflow

- Added Make targets for building the Hugo site and deploying it to One.com
  over SFTP with `lftp`.
- Added a deployment dry run for inspecting uploads and deletions before
  publishing.
- Kept SFTP credentials local and ignored by Git.
- Recognized that `mirror --reverse --delete` can remove remote files, so real
  deployment requires deliberate confirmation and prior validation.

## 2026-07-29 — Refined the homepage and About page

- Configured PaperMod profile mode for a compact personal homepage.
- Added professional summary text covering systems engineering, scientific
  infrastructure, software development, and Linux.
- Developed the About page as an introduction to Jon's professional work,
  forthcoming MSc studies, and Project Polaris.
- Added custom About-page image positioning and made the profile image link back
  to the homepage.
- Introduced a pencil-sketch profile image for the homepage while retaining the
  photographic profile image on the About page.

## 2026-07-28 — Began developing the Hugo site

- Established Hugo as the static-site generator and PaperMod as the theme.
- Added the initial About page and began shaping the site's content and visual
  identity.

## 2026-07-27 — Initialized jonleithe.no

- Created the Git repository and initial Hugo project structure.
- Added PaperMod as the site theme.
