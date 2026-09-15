# jonleithe.no — Agent Instructions

## Project context

Before making substantial changes, consult:

- `AUTHOR.md` for the maintainer's background, preferences, and goals for the
  website.
- `PROJECT_HISTORY.md` for durable architectural decisions and recent
  milestones.

Update `PROJECT_HISTORY.md` only when work introduces a significant decision,
milestone, or change in project direction.

## Project role

This repository owns Jon Leithe's public website at `https://www.jonleithe.no/`.
It is a Hugo site using the PaperMod theme, and it owns final website assembly and
deployment to One.com.

Keep this repository focused on the website. Academic note sources and their PDF
production belong in the adjacent Project Polaris Academy repository.

## Related repository and ownership boundary

- Website repository: `/home/jole/projects/jonleithe.no`
  - Hugo homepage, About page, navigation, styling, and static assets.
  - Final assembly of everything published under `www.jonleithe.no`.
  - One.com deployment.
- Notes repository: `/home/jole/projects/project-polaris-academy`
  - Source of truth for academic and engineering notes under `notes/`.
  - Quarto configuration, filters, LaTeX customization, and rendered artifacts.
  - Individual note PDFs, subject PDFs, the complete Academy book, and the
    generated notes website.

Do not duplicate the Academy Markdown sources in this repository. The website
should consume a generated Quarto artifact instead.

## Agreed publishing architecture

The intended flow is:

```text
project-polaris-academy/notes
        |
        v
Quarto PDF and HTML builds
        |
        v
project-polaris-academy/build/site
        |
        v
jonleithe.no/public/notes
        |
        v
One.com
```

Hugo remains responsible for `/`, `/about/`, and the surrounding personal site.
The generated Quarto site or book will be published as a subsite at `/notes/`.
The Hugo "Engineering Notes" menu item should link to `/notes/` once that
integration is implemented.

## Academy Make interface

The following interface is implemented in the Academy repository's Makefile:

```sh
make note NOTE=linear-algebra/courses/khan-academy/01-vectors-and-spaces.md
make notes
make linear-algebra
make book
make site
make preview
make clean
make help
```

Expected meanings:

- `make note NOTE=...` renders one note as PDF. `NOTE=` is intentionally explicit.
- `make notes` renders individual PDFs for all notes.
- `make linear-algebra` renders one combined Linear Algebra PDF.
- `make book` renders the complete Project Polaris Academy PDF.
- `make site` creates the Quarto HTML site or book artifact.
- `make preview` starts a suitable local Quarto preview.
- `make clean` removes generated Academy output only.
- `make help` documents the supported targets and examples.

Quarto profiles may be used in the Academy repository to support individual-note,
subject, book, and website builds without duplicating configuration.

## Planned website integration

Once the Academy `make site` target and output directory are stable, extend this
repository's Makefile so its website build can:

1. Run `make -C ../project-polaris-academy site`.
2. Build the Hugo site.
3. Copy or synchronize the Academy's generated `build/site/` artifact into
   `public/notes/`.
4. Validate links, images, mathematics, and navigation under `/notes/` before
   deployment.

Keep the dependency direction one-way: Academy sources produce an artifact, and
this website consumes that artifact. Do not make Academy rendering depend on the
website repository.

## Current Hugo conventions

- Site configuration is in `hugo.toml`.
- The active theme is PaperMod, configured as a Git submodule.
- Homepage profile mode is configured in `hugo.toml`.
- About content is in `content/about/_index.md`.
- Custom styles belong in `assets/css/extended/custom.css`.
- Site images belong under `static/images/` and are referenced from the site as
  `/images/<filename>`.
- Generated Hugo output is written to `public/`.

Inspect the working tree before editing. The user may have uncommitted content,
CSS, configuration, image, or generated-site changes; preserve them and avoid
overwriting unrelated work.

## Build and deployment safety

The current website Makefile provides Hugo build and One.com deployment targets.
Deployment uses `lftp mirror --reverse --delete`, so deletion on the remote side
is possible. Before a real deployment:

1. Confirm the intended local `public/` contents.
2. Run the dry-run deployment target.
3. Deploy only when the user explicitly requests it.

Keep SFTP credentials local. `sftp.creds` must remain ignored by Git and must
never be printed, committed, or copied into generated site output. Do not add
secrets to `AGENTS.md`, the Makefile, Hugo configuration, or tracked scripts.

## Validation expectations

For website-only changes, use an appropriate Hugo build and inspect relevant
generated paths. For the future notes integration, validate at least:

- the Academy `make site` command succeeds;
- the generated artifact lands at the expected path;
- `/notes/` opens from Hugo navigation;
- internal note links, images, equations, and search/navigation work beneath the
  `/notes/` URL prefix;
- the Hugo homepage and About page remain unchanged unless intentionally edited;
- the deployment dry run contains only the expected uploads and deletions.

## Near-term implementation order

1. Settle the Academy Quarto book/site structure and stable `build/site/` output.
2. Add artifact integration to this repository's Makefile.
3. Enable the Hugo "Engineering Notes" navigation entry.
4. Test locally, perform a deployment dry run, and publish only on request.
