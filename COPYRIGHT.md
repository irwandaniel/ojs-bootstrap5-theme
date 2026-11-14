# Copyright and licensing

## Theme: Bootstrap 5 for Open Journal Systems

This repository is a **derivative work** of the Bootstrap 3 theme for Open
Journal Systems. It is distributed under the **GNU General Public License,
version 3** (see [`LICENSE`](LICENSE)).

### Original work

The upstream theme and the OJS templates it is based on are:

- Copyright (c) 2014–2023 Simon Fraser University
- Copyright (c) 2003–2023 John Willinsky
- Copyright (c) 2016–2023 the contributors of the Bootstrap 3 theme for OJS
- Upstream project: <https://github.com/pkp/bootstrap3> (originally
  <https://github.com/NateWr/bootstrap3>)
- Licensed under the GNU GPL v3

The original copyright notices are retained in every source file.

### Modifications

- **Copyright (c) 2026 Irwan Daniel - ([Webmaxindo](http://www.webmaxindo.com/))**
- Modification date: **2026-11-14**
- Modified work: Bootstrap 5 theme for OJS 3.5 (`plugins/themes/bootstrap5`)

The modifications include:

- Porting the theme from Bootstrap 3 to **Bootstrap 5.3.9**
- Migrating all Smarty templates to Bootstrap 5 markup and components
- Vendoring Bootstrap, the Bootstrap RTL build and eight Bootswatch 5.3.8
  presets, so that no CDN is used
- Serving all webfonts locally and removing the Google Fonts imports from the
  Bootswatch builds
- Adding a color mode system (light / dark / follow system) with a header
  switcher, early-paint script and `localStorage` persistence
- Adding a modern UI layer (design tokens, sticky header, cards, focus states,
  reduced-motion support)
- Removing the obsolete Bootstrap 3 LESS sources, glyphicons and RTL stylesheet
- Renaming the plugin internals from `bootstrap3` to `bootstrap5`

Every modified source file carries a prominent notice:

```
Modified (c) 2026 Irwan Daniel - ([Webmaxindo](http://www.webmaxindo.com/))
```

in accordance with section 5(a) of the GNU GPL v3.

### Source code

The complete corresponding source code is this repository. It contains the PHP
plugin, Smarty templates, LESS stylesheets, JavaScript and locale files. The
stylesheet served by OJS is compiled at runtime from `styles/theme.less` by the
OJS LESS compiler. The files under `bootstrap/` are unmodified third-party
distributions (see below) and are not part of the GPL-covered theme code.

### No warranty

The work is provided “as is”, without warranty of any kind, as stated in
sections 15 and 16 of the GNU GPL v3.

---

## Third-party components

These components are separate works, distributed with their own licences. They
are aggregated with the theme and are not relicensed under the GPL.

| Component | Version | Licence | Licence file |
| --- | --- | --- | --- |
| Bootstrap | 5.3.9 | MIT | [`bootstrap/LICENSE`](bootstrap/LICENSE) |
| Bootswatch (presets) | 5.3.8 | MIT | [`bootstrap/css/presets/LICENSE`](bootstrap/css/presets/LICENSE) |
| Lato | v17 | SIL Open Font License 1.1 | [`fonts/licenses/lato-OFL.txt`](fonts/licenses/lato-OFL.txt) |
| News Cycle | v17 | SIL Open Font License 1.1 | [`fonts/licenses/newscycle-OFL.txt`](fonts/licenses/newscycle-OFL.txt) |
| Raleway | v18 | SIL Open Font License 1.1 | [`fonts/licenses/raleway-OFL.txt`](fonts/licenses/raleway-OFL.txt) |
| Source Sans Pro | v14 | SIL Open Font License 1.1 | [`fonts/licenses/sourcesans-OFL.txt`](fonts/licenses/sourcesans-OFL.txt) |
| Open Sans | v18 | Apache License 2.0 | [`fonts/licenses/Apache-2.0.txt`](fonts/licenses/Apache-2.0.txt) |
| Roboto | v20 | Apache License 2.0 | [`fonts/licenses/Apache-2.0.txt`](fonts/licenses/Apache-2.0.txt) |
| Ubuntu | v15 | Ubuntu Font Licence 1.0 | [`fonts/licenses/ubuntu-UFL.txt`](fonts/licenses/ubuntu-UFL.txt) |

Font Awesome is loaded from the OJS core installation
(`lib/pkp/styles/fontawesome/`) and is not redistributed with this theme.

Bootstrap Icons, Bootstrap documentation code and the color mode toggler
pattern are referenced for interoperability; the JavaScript in `js/theme.js` is
an original implementation for OJS.
