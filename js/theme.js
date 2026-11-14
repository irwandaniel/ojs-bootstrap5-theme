/**
 * @file plugins/themes/bootstrap5/js/theme.js
 *
 * Copyright (c) 2026 Irwan Daniel - Webmaxindo.com
 * Modified (c) 2026 Irwan Daniel - Webmaxindo.com
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * Color mode switcher and small progressive enhancements for the theme.
 * The behaviour follows the color mode toggler pattern documented in the
 * Bootstrap 5.3 documentation:
 * https://getbootstrap.com/docs/5.3/customize/color-modes/#javascript
 * The implementation is original code for Open Journal Systems.
 */
(function () {
	'use strict';

	var STORAGE_KEY = 'ojs.theme';
	var root = document.documentElement;
	var media = window.matchMedia('(prefers-color-scheme: dark)');

	function getStored() {
		try {
			return window.localStorage.getItem(STORAGE_KEY);
		} catch (e) {
			return null;
		}
	}

	function setStored(value) {
		try {
			window.localStorage.setItem(STORAGE_KEY, value);
		} catch (e) {
			// Storage may be unavailable (private mode, disabled cookies).
		}
	}

	function normalize(mode) {
		return (mode === 'light' || mode === 'dark' || mode === 'auto') ? mode : 'auto';
	}

	function resolve(mode) {
		if (mode === 'light' || mode === 'dark') {
			return mode;
		}
		return media.matches ? 'dark' : 'light';
	}

	function updateSwitcher(mode) {
		var items = document.querySelectorAll('[data-bs-theme-value]');
		Array.prototype.forEach.call(items, function (item) {
			var active = item.getAttribute('data-bs-theme-value') === mode;
			item.classList.toggle('active', active);
			item.setAttribute('aria-pressed', active ? 'true' : 'false');
			var check = item.querySelector('.color-mode-check');
			if (check) {
				check.classList.toggle('invisible', !active);
			}
		});
	}

	function updateMetaThemeColor() {
		var meta = document.querySelector('meta[name="theme-color"]');
		if (!meta) {
			return;
		}
		var color = window.getComputedStyle(document.body).backgroundColor;
		if (color && color !== 'rgba(0, 0, 0, 0)' && color !== 'transparent') {
			meta.setAttribute('content', color);
		}
	}

	function apply(mode, options) {
		options = options || {};
		mode = normalize(mode);

		root.setAttribute('data-color-mode-preference', mode);
		root.setAttribute('data-bs-theme', resolve(mode));
		updateSwitcher(mode);

		if (options.persist) {
			setStored(mode);
		}

		window.requestAnimationFrame(updateMetaThemeColor);

		document.dispatchEvent(new CustomEvent('ojs:colorModeChange', {
			detail: { mode: mode, resolved: resolve(mode) }
		}));
	}

	function closeSwitcher() {
		var toggle = document.getElementById('colorModeToggle');
		if (!toggle || !window.bootstrap || !window.bootstrap.Dropdown) {
			return;
		}
		var instance = window.bootstrap.Dropdown.getInstance(toggle);
		if (instance) {
			instance.hide();
		}
	}

	/**
	 * Mark the navigation item that matches the current URL. OJS does not
	 * expose an active flag for menu items, so this is a progressive
	 * enhancement on top of the server-rendered navigation.
	 */
	function initActiveNav() {
		var nav = document.getElementById('main-navigation');
		if (!nav) {
			return;
		}

		var here = window.location.pathname.replace(/\/+$/, '');
		var best = null;
		var bestLength = -1;

		Array.prototype.forEach.call(nav.querySelectorAll('a.nav-link[href]'), function (link) {
			var url;
			try {
				url = new URL(link.href, window.location.origin);
			} catch (e) {
				return;
			}
			if (url.origin !== window.location.origin) {
				return;
			}

			var path = url.pathname.replace(/\/+$/, '');
			if (!path) {
				return;
			}

			var matches = here === path || here.indexOf(path + '/') === 0;
			if (matches && path.length > bestLength) {
				best = link;
				bestLength = path.length;
			}
		});

		if (!best) {
			return;
		}

		best.classList.add('active');
		best.setAttribute('aria-current', 'page');

		var dropdown = best.closest('.dropdown');
		if (dropdown) {
			var toggle = dropdown.querySelector('.dropdown-toggle');
			if (toggle) {
				toggle.classList.add('active');
			}
		}
	}

	/**
	 * Toggle password visibility for fields marked with data-toggle-password.
	 */
	function initPasswordToggles() {
		Array.prototype.forEach.call(document.querySelectorAll('[data-toggle-password]'), function (button) {
			var input = document.getElementById(button.getAttribute('data-toggle-password'));
			if (!input) {
				return;
			}

			var showLabel = button.getAttribute('data-label-show') || 'Show password';
			var hideLabel = button.getAttribute('data-label-hide') || 'Hide password';

			button.addEventListener('click', function () {
				var show = input.getAttribute('type') === 'password';
				input.setAttribute('type', show ? 'text' : 'password');
				button.setAttribute('aria-pressed', show ? 'true' : 'false');
				button.setAttribute('aria-label', show ? hideLabel : showLabel);

				var icon = button.querySelector('.fa');
				if (icon) {
					icon.classList.toggle('fa-eye', !show);
					icon.classList.toggle('fa-eye-slash', show);
				}

				input.focus();
			});
		});
	}

	function init() {
		apply(getStored() || root.getAttribute('data-color-mode-default') || 'auto');
		initActiveNav();
		initPasswordToggles();

		Array.prototype.forEach.call(document.querySelectorAll('[data-bs-theme-value]'), function (item) {
			item.addEventListener('click', function () {
				apply(item.getAttribute('data-bs-theme-value'), { persist: true });
				closeSwitcher();
			});
		});

		var onSystemChange = function () {
			// Only follow the system preference while the visitor has not
			// explicitly selected a mode.
			if (!getStored()) {
				apply('auto');
			}
		};

		if (media.addEventListener) {
			media.addEventListener('change', onSystemChange);
		} else if (media.addListener) {
			media.addListener(onSystemChange);
		}
	}

	if (document.readyState === 'loading') {
		document.addEventListener('DOMContentLoaded', init);
	} else {
		init();
	}
})();
