# Publishing on GitHub

This document describes how to publish this theme as a GitHub repository and how
to produce the downloadable plugin archive through GitHub Releases.

## Repository description

Use this text as the repository description on GitHub:

```
Bootstrap 5 theme for Open Journal Systems 3.5 (GPLv3)
```

## Repository topics

Add these topics to the repository:

```
ojs
bootstrap5
pkp
theme
```

## Create the repository

### With the GitHub CLI

```bash
cd plugins/themes/bootstrap5

git init
git add .
git commit -m "Initial release: Bootstrap 5 theme for OJS 3.5"
git branch -M main

# Create the repository and push the first commit
gh repo create <owner>/<repository> \
  --public \
  --description "Bootstrap 5 theme for Open Journal Systems 3.5 (GPLv3)" \
  --source . \
  --remote origin \
  --push

# Add the topics
gh repo edit --add-topic ojs,bootstrap5,pkp,theme
```

### With the GitHub website

1. Create a new public repository.
2. Set the description to
   `Bootstrap 5 theme for Open Journal Systems 3.5 (GPLv3)`.
3. Add the topics `ojs`, `bootstrap5`, `pkp` and `theme`.
4. Push this directory to the repository.

## Release a new version

The theme version lives in `version.xml` (`<release>1.0.0.0</release>`). The Git
tag must match the first three parts of that version: `v1.0.0`.

1. Update `version.xml`, `CHANGELOG.md` and `README.md` when needed.
2. Commit the changes.
3. Create and push the tag:

```bash
git tag -a v1.0.0 -m "Bootstrap 5 theme for OJS 3.5 - 1.0.0"
git push origin main
git push origin v1.0.0
```

The workflow in `.github/workflows/release.yml` then:

- verifies that the tag matches `<release>` in `version.xml`,
- builds `bootstrap5-1.0.0.zip` with `git archive` and a top-level `bootstrap5/`
  directory,
- publishes a GitHub Release with the archive attached and the installation
  instructions from `.github/release-notes.md`.

### Build the archive locally

The same archive can be produced without GitHub:

```bash
git archive --format=zip --prefix=bootstrap5/ -o bootstrap5-1.0.0.zip HEAD
```

The archive contains a `bootstrap5/` directory. Users extract it into
`plugins/themes/`, which results in `plugins/themes/bootstrap5/`.

`git archive` respects the `export-ignore` rules in `.gitattributes`, so the
GitHub workflow files and publishing documentation are not shipped inside the
plugin archive.

### Publish a release manually

```bash
gh release create v1.0.0 bootstrap5-1.0.0.zip \
  --title "Bootstrap 5 theme for OJS 3.5 v1.0.0" \
  --notes-file .github/release-notes.md
```

## Checklist

- [ ] `version.xml` and the Git tag match
- [ ] `CHANGELOG.md` is up to date
- [ ] `LICENSE`, `COPYRIGHT.md` and `fonts/licenses/` are present
- [ ] The archive extracts to `bootstrap5/` and contains `version.xml`
- [ ] The theme installs and activates on a clean OJS 3.5 installation
- [ ] Repository description and topics are set
