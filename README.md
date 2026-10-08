# `rme`: Regression Models for Epidemiology

## Getting Started

This repository uses a git submodule for LaTeX macros. When cloning, use:

```bash
git clone --recurse-submodules https://github.com/Morrison-Lab/rme.git
```

Or if already cloned:

```bash
git submodule update --init --recursive
```

To move the pinned macros forward to the latest upstream `main`:

```bash
git submodule update --remote --checkout latex-macros
git add latex-macros
git commit -m "Update latex-macros submodule"
```

For more details, see [SUBMODULE_SETUP.md](SUBMODULE_SETUP.md).

## Code of Conduct

Please note that the `rme` project is released with a
[Contributor Code of Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
