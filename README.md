# Bootstrap 5 for OJS 3.5

> **Modified version.** This theme is a derivative work of the Bootstrap 3 theme
> for OJS, ported to Bootstrap 5. **Modified (c) 2026 Irwan Daniel -
> ([Webmaxindo](http://www.webmaxindo.com/)).** Licensed under the GNU GPL v3; see [`LICENSE`](LICENSE) and
> [`COPYRIGHT.md`](COPYRIGHT.md).

A theme for Open Journal Systems 3.5 that implements the [Bootstrap 5](https://getbootstrap.com/) components on the reader frontend.

All CSS and JavaScript is served from this plugin. **No CDN is used**, so the theme works on installations without outbound internet access.

## Requirements

- OJS 3.5 (or a compatible PKP application)
- A browser supported by Bootstrap 5.3

## Download

Download the latest `bootstrap5-<version>.zip` from the repository's
**Releases** page. The archive contains a top-level `bootstrap5/` directory, so
it can be extracted directly into the `plugins/themes/` directory of your OJS
installation.

## Installation

1. Download the latest release archive and extract it into `plugins/themes/` so
   that the final path is `plugins/themes/bootstrap5/`.
2. Go to **Settings → Website → Plugins → Installed plugins** and enable the **Bootstrap 5 Base Theme**.
3. Go to **Settings → Website → Appearance** and select the theme and, if you want, one of the available Bootstrap themes.
4. Clear the template cache (**Administration → Clear cache**) if styles do not update.

## Theme options

### Bootstrap theme

Nine styles are bundled:

| Option | Stylesheet | Notes |
| --- | --- | --- |
| Bootstrap 5 (default) | `bootstrap/css/bootstrap.min.css` | Bootstrap 5.3.9 |
| Cerulean | `bootstrap/css/presets/cerulean.min.css` | Bootswatch 5.3.8 |
| Cosmo | `bootstrap/css/presets/cosmo.min.css` | Bootswatch 5.3.8, Source Sans Pro (local) |
| Darkly | `bootstrap/css/presets/darkly.min.css` | Bootswatch 5.3.8, Lato (local) |
| Flatly | `bootstrap/css/presets/flatly.min.css` | Bootswatch 5.3.8, Lato (local) |
| Journal | `bootstrap/css/presets/journal.min.css` | Bootswatch 5.3.8, News Cycle (local) |
| Lumen | `bootstrap/css/presets/lumen.min.css` | Bootswatch 5.3.8, Source Sans Pro (local) |
| Sandstone | `bootstrap/css/presets/sandstone.min.css` | Bootswatch 5.3.8, Roboto (local) |
| United | `bootstrap/css/presets/united.min.css` | Bootswatch 5.3.8, Ubuntu (local) |

The default option ships Bootstrap 5.3.9. The Bootswatch presets are pre-compiled
against Bootstrap 5.3.8, so a patch-level difference between the default style
and the presets is expected.

The `@import` statements that the Bootswatch builds use to fetch Google Fonts
have been removed. The fonts are served from the `fonts/` directory of this
plugin instead, through `styles/fonts/*.less`.

### Color mode

The theme supports Bootstrap's [color modes](https://getbootstrap.com/docs/5.3/customize/color-modes/).
The **Color mode** option sets the default mode:

| Option | Behaviour |
| --- | --- |
| Follow the system preference (default) | Light or dark, depending on `prefers-color-scheme` |
| Light | Always light until the visitor changes it |
| Dark | Always dark until the visitor changes it |

A color mode switcher is rendered in the site header. Visitors can choose
light, dark or "follow system", and their choice is stored in `localStorage`
under the key `ojs.theme`. The switcher is based on the toggler from the
Bootstrap documentation:

- An inline script in `templates/frontend/components/headerHead.tpl` applies the
  stored mode before the first paint, so reloading does not flash the wrong
  theme.
- `js/theme.js` handles the switcher, keeps `aria-pressed` in sync, follows
  system changes while the visitor has not chosen a mode, and updates the
  `theme-color` meta tag.
- The mode is applied with `data-bs-theme` on `<html>`, so every Bootstrap
  component adapts automatically, including components inside the modal and
  dropdown top layers.

Custom color modes are possible without recompiling Bootstrap by adding a
`[data-bs-theme="my-mode"]` block that overrides Bootstrap's CSS variables:

```css
[data-bs-theme="sepia"] {
	--bs-body-bg: #f5ecd9;
	--bs-body-color: #3b3025;
	--bs-border-color: #d8c9ac;
}
```

The Bootswatch presets do not ship a dark variant. When a visitor selects dark
mode while a preset is active, Bootstrap's built-in dark palette is applied on
top of the preset's component styling.

### Usage statistics

The theme can display a download statistics chart on the article page. The
chart is rendered by the OJS usage statistics API.

## Right-to-left languages

Bootstrap 5 ships its own RTL build (`bootstrap/css/bootstrap.rtl.min.css`).
When the active locale is right-to-left, the theme loads that stylesheet
instead of the selected Bootstrap theme, because the Bootswatch builds do not
include an RTL variant. The theme also sets the `dir` attribute on the page.

## Customising

- `styles/theme.less` contains the OJS specific adjustments and the visual
  design layer on top of Bootstrap. It is compiled by OJS, so LESS variables and
  nesting can be used. Design tokens such as `--ojs-radius`, `--ojs-shadow` and
  `--ojs-transition` are declared at the top of the file.
- All colours are read from Bootstrap's CSS variables (`--bs-body-bg`,
  `--bs-border-color`, `--bs-primary`, ...), which means the design follows both
  the selected Bootstrap theme and the active color mode.
- `templates/` overrides the frontend templates of the application.
- `js/theme.js` contains the color mode switcher.
- When upgrading Bootstrap, replace `bootstrap/css/bootstrap.min.css`,
  `bootstrap/css/bootstrap.rtl.min.css` and `bootstrap/js/bootstrap.bundle.min.js`
  with the new distribution files and update the version in this README.

## Licence

This theme is a derivative work of the Bootstrap 3 theme for OJS and is
distributed under the **GNU General Public License, version 3**. The full
licence text is in [`LICENSE`](LICENSE). Copyright, modification and
third-party licence details are documented in [`COPYRIGHT.md`](COPYRIGHT.md).

- Original theme and OJS templates: Copyright (c) 2014–2023 Simon Fraser
  University, Copyright (c) 2003–2023 John Willinsky, and the contributors of
  the Bootstrap 3 theme for OJS.
- Modifications: **Modified (c) 2026 Irwan Daniel - ([Webmaxindo](http://www.webmaxindo.com/))**.
- Every modified source file carries this modification notice, as required by
  section 5(a) of the GNU GPL v3.
- The complete corresponding source code is this repository.

Bundled third-party assets (separate works, not relicensed under the GPL):

- Bootstrap 5.3.9, MIT licence (`bootstrap/LICENSE`)
- Bootswatch 5.3.8 presets, MIT licence (`bootstrap/css/presets/LICENSE`)
- Lato, News Cycle, Raleway and Source Sans Pro, SIL Open Font License 1.1
  (`fonts/licenses/*-OFL.txt`)
- Open Sans and Roboto, Apache License 2.0 (`fonts/licenses/Apache-2.0.txt`)
- Ubuntu, Ubuntu Font Licence 1.0 (`fonts/licenses/ubuntu-UFL.txt`)

Font Awesome is loaded from the OJS core installation and is not redistributed
with this theme.

## Credits

This theme is derived from the community Bootstrap 3 theme for OJS. Thanks to
everyone who contributed to that project:

- Nate Wright, @NateWr ([PKP](https://pkp.sfu.ca))
- Roger Gillis, @rcgillis ([PKP](https://pkp.sfu.ca)/[Dalhousie](http://www.dal.ca/))
- Sophy Ouch, @sophyo ([Érudit](http://www.erudit.org/en/))
- Michael Felczak, @mfelczak ([PKP](https://pkp.sfu.ca))
- Marc Behiels ([WebKitchen](http://webkitchen.ca/))
- Ted Roeder ([Cold Spring Harbor Laboratory](http://www.cshl.edu/))
- William Alejandro Ortiz Porras, @wortizBiteca ([Biteca Ltda, Columbia](http://www.biteca.com/))
- Ramón Martins Sodoma da Fonseca (IBCIT, Brazil)
- Alexander Kiselev, @Avernial
- Nikos Kasioumis, @kasioumis
- Karam Qubsi, @karamqubsi
- Simon Mitternacht, @mittinatten
- Marco Tullney, @mtub
- Dennis Müller, @dennmuel ([UB Mannheim](https://www.bib.uni-mannheim.de/))
- Clinton Graham, @ctgraham (University of Pittsburgh)

Bootstrap 5 port, color modes and design refresh:

- **Irwan Daniel - ([Webmaxindo](http://www.webmaxindo.com/))** (2026)
