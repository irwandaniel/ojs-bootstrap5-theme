# Changelog

All notable changes to this theme are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/)
and this project adheres to [Semantic Versioning](https://semver.org/).

## [1.0.0] - 2026-11-14

Initial public release of the Bootstrap 5 theme for OJS 3.5.

### Added

- Bootstrap 5.3.9 integration with a locally hosted stylesheet and JavaScript
  bundle (no CDN).
- Bootstrap 5.3.9 RTL build, loaded automatically for right-to-left locales.
- Eight Bootswatch 5.3.8 presets: Cerulean, Cosmo, Darkly, Flatly, Journal,
  Lumen, Sandstone and United.
- Color mode support (light / dark / follow system) with a header switcher,
  early-paint script, `localStorage` persistence and a `theme-color` update.
- Modern UI layer: design tokens, sticky translucent header, article and issue
  cards, sidebar block cards, focus-visible states, reduced-motion support and
  dark-mode aware shadows.
- Local webfont hosting with the Google Fonts imports removed from the
  Bootswatch builds.
- License and copyright documentation (`COPYRIGHT.md`) and third-party font
  licence texts.
- GitHub release workflow (`.github/workflows/release.yml`) that builds a
  `bootstrap5-<version>.zip` archive and attaches it to GitHub Releases.
- Publishing documentation (`PUBLISHING.md`) with the repository description,
  topics and release steps.

### Changed

- Migrated all frontend templates from Bootstrap 3 to Bootstrap 5 markup,
  including navigation, dropdowns, forms, pagination, breadcrumbs and alerts.
- Rebuilt the header as a single Bootstrap 5 navbar with `navbar-expand-xl`,
  `navbar-toggler`, `collapse`, `navbar-nav`, a search form and the user menu
  inside the collapse. The header is sticky on large screens and uses
  `bg-body-tertiary`.
- Added active navigation states (`aria-current="page"` and `.active`) through a
  small progressive enhancement in `js/theme.js`.
- Migrated article, issue, announcement and journal summaries to Bootstrap card
  markup (`card`, `card-body`, `card-title`) and card CSS variables.
- Rebuilt pagination with `page-item`/`page-link`, disabled states, accessible
  labels, chevron icons and a page summary.
- Replaced remaining hard-coded colours with Bootstrap semantic tokens
  (`bg-body-tertiary`, `--bs-card-*`, `--bs-primary-bg-subtle`,
  `text-body-secondary`).
- Reworked login, registration, password reset and search filter forms:
  card-based layout, accessible labels, autocomplete hints and password
  visibility toggles.
- Replaced the Bootstrap 3 LESS sources with pre-compiled Bootstrap 5 assets
  and a dedicated `styles/theme.less` override layer.
- Renamed the plugin internals from `bootstrap3` to `bootstrap5`.
- Replaced glyphicons with Font Awesome from the OJS core.
- Updated the plugin version metadata to `1.0.0.0`.

### Removed

- Bootstrap 3 LESS sources, glyphicons, Bootstrap 3 RTL stylesheet and the
  eighteen Bootstrap 3 Bootswatch presets.
- CDN and Google Fonts dependencies.
