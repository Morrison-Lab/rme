# LaTeX Macros Submodule Setup

This repository uses a git submodule for shared LaTeX macros. The
superproject pins the exact submodule commit used by the notes, while
`.gitmodules` records `main` as the upstream branch to use when pulling
future macro updates.

## Current Status

- Submodule URL: https://github.com/d-morrison/macros.git
- Submodule branch: `main`
- Submodule path: `latex-macros/`
- Chapter sources include `latex-macros/macros.qmd`
- GitHub Actions workflows check out submodules

## For Future Clones

When cloning this repository, include submodules:

```bash
git clone --recurse-submodules https://github.com/Morrison-Lab/rme.git
```

Or if already cloned:

```bash
git submodule update --init --recursive
```

## Updating the Macros

To move this repository's pinned macro version to the latest upstream
`main`:

```bash
git submodule update --remote --checkout latex-macros
git add latex-macros
git commit -m "Update latex-macros submodule"
git push
```

If you need to edit the macros themselves, commit and push those changes
inside `latex-macros/` first, then commit the updated `latex-macros`
pointer in this repository.
