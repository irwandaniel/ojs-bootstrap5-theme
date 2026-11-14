{**
 * templates/frontend/components/headerHead.tpl
 *
 * Copyright (c) 2014-2023 Simon Fraser University
 * Copyright (c) 2000-2023 John Willinsky
 * Modified (c) 2026 Irwan Daniel - Webmaxindo.com
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * Common site header <head> tag and contents.
 *}
<head>
	<meta charset="{$defaultCharset|escape}">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="color-scheme" content="light dark">
	<meta name="theme-color" content="#ffffff">
	<script>
		/* Apply the visitor's color mode before the first paint to avoid a flash
		   of the wrong theme. js/theme.js handles the switcher afterwards. */
		(function () {
			'use strict';
			try {
				var root = document.documentElement;
				var stored = window.localStorage.getItem('ojs.theme');
				var fallback = root.getAttribute('data-color-mode-default') || 'auto';
				var mode = stored || fallback;
				var resolved = mode;
				if (mode !== 'light' && mode !== 'dark') {
					mode = 'auto';
					resolved = window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light';
				}
				root.setAttribute('data-color-mode-preference', mode);
				root.setAttribute('data-bs-theme', resolved);
			} catch (e) {
				/* localStorage or matchMedia is unavailable; keep the server value */
			}
		})();
	</script>
	<title>
		{$pageTitleTranslated|strip_tags}
		{* Add the journal name to the end of page titles *}
		{if $requestedPage|escape|default:"index" != 'index' && $currentContext && $currentContext->getLocalizedName()}
			| {$currentContext->getLocalizedName()}
		{/if}
	</title>

	{load_header context="frontend"}
	{load_stylesheet context="frontend"}
</head>
