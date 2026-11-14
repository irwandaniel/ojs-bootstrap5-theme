<?php

/**
 * @file plugins/themes/bootstrap5/Bootstrap5Plugin.php
 *
 * Copyright (c) 2014-2023 Simon Fraser University
 * Copyright (c) 2003-2023 John Willinsky
 * Modified (c) 2026 Irwan Daniel - ([Webmaxindo](http://www.webmaxindo.com/))
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * @class Bootstrap5Plugin
 * @brief Bootstrap 5 theme for OJS
 */

namespace APP\plugins\themes\bootstrap5;

use APP\core\Application;
use PKP\config\Config;
use PKP\facades\Locale;
use PKP\plugins\ThemePlugin;

class Bootstrap5Plugin extends ThemePlugin
{
    /**
     * The Bootstrap themes shipped with this plugin. Each theme is a
     * pre-compiled Bootstrap 5 stylesheet, so no CDN is required.
     *
     * @var array<string, string> Preset name => local font stylesheet
     */
    public const THEMES = [
        'bootstrap5' => '',
        'cerulean' => '',
        'cosmo' => 'styles/fonts/sourceSansPro.less',
        'darkly' => 'styles/fonts/lato.less',
        'flatly' => 'styles/fonts/lato.less',
        'journal' => 'styles/fonts/newsCycle.less',
        'lumen' => 'styles/fonts/sourceSansPro.less',
        'sandstone' => 'styles/fonts/roboto.less',
        'united' => 'styles/fonts/ubuntu.less',
    ];

    /**
     * Initialize the theme
     */
    public function init(): void
    {
        // Register option for bootstrap themes
        $this->addOption('bootstrapTheme', 'FieldOptions', [
            'type' => 'radio',
            'label' => __('plugins.themes.bootstrap5.options.bootstrapTheme.label'),
            'description' => __('plugins.themes.bootstrap5.options.bootstrapTheme.description'),
            'options' => array_map(
                fn (string $theme) => [
                    'value' => $theme,
                    'label' => __('plugins.themes.bootstrap5.options.bootstrapTheme.' . $theme),
                ],
                array_keys(self::THEMES)
            ),
            'default' => 'bootstrap5',
        ]);

        // Add usage stats display options
        $this->addOption('displayStats', 'FieldOptions', [
            'type' => 'radio',
            'label' => __('plugins.themes.bootstrap5.option.displayStats.label'),
            'options' => [
                [
                    'value' => 'none',
                    'label' => __('plugins.themes.bootstrap5.option.displayStats.none'),
                ],
                [
                    'value' => 'bar',
                    'label' => __('plugins.themes.bootstrap5.option.displayStats.bar'),
                ],
                [
                    'value' => 'line',
                    'label' => __('plugins.themes.bootstrap5.option.displayStats.line'),
                ],
            ],
            'default' => 'none',
        ]);

        // Add the default color mode. Visitors can override it with the color
        // mode switcher in the site header.
        $this->addOption('colorMode', 'FieldOptions', [
            'type' => 'radio',
            'label' => __('plugins.themes.bootstrap5.option.colorMode.label'),
            'description' => __('plugins.themes.bootstrap5.option.colorMode.description'),
            'options' => [
                [
                    'value' => 'auto',
                    'label' => __('plugins.themes.bootstrap5.option.colorMode.auto'),
                ],
                [
                    'value' => 'light',
                    'label' => __('plugins.themes.bootstrap5.option.colorMode.light'),
                ],
                [
                    'value' => 'dark',
                    'label' => __('plugins.themes.bootstrap5.option.colorMode.dark'),
                ],
            ],
            'default' => 'auto',
        ]);

        $request = Application::get()->getRequest();

        // Load Bootstrap from a local copy. Never from a CDN.
        $bootstrapTheme = $this->getOption('bootstrapTheme');
        if (empty($bootstrapTheme) || !isset(self::THEMES[$bootstrapTheme]) || $bootstrapTheme === 'bootstrap5') {
            $bootstrapTheme = 'bootstrap5';
            $this->addStyle('bootstrap', 'bootstrap/css/bootstrap.min.css');
        } else {
            $this->addStyle('bootstrap', 'bootstrap/css/presets/' . $bootstrapTheme . '.min.css');
        }

        // Bootstrap 5 ships its own RTL build. The Bootstrap theme presets do
        // not have an RTL build, so the official RTL stylesheet replaces them.
        $localeMetadata = Locale::getMetadata(Locale::getLocale());
        if ($localeMetadata->isRightToLeft()) {
            $this->addStyle('bootstrap-rtl', 'bootstrap/css/bootstrap.rtl.min.css');
        }

        // Locally hosted webfonts used by some of the Bootswatch themes
        if (self::THEMES[$bootstrapTheme]) {
            $this->addStyle('bootstrap-font', self::THEMES[$bootstrapTheme]);
        }

        // OJS specific styles on top of Bootstrap
        $this->addStyle('bootstrap5-theme', 'styles/theme.less');

        // Load icon font FontAwesome from the OJS core
        $this->addStyle(
            'fontAwesome',
            $request->getBaseUrl() . '/lib/pkp/styles/fontawesome/fontawesome.css',
            ['baseUrl' => '']
        );

        // Load jQuery from a local copy.
        $min = Config::getVar('general', 'enable_minified') ? '.min' : '';
        // Use an empty `baseUrl` argument to prevent the theme from looking for
        // the files within the theme directory
        $jquery = $request->getBaseUrl() . '/js/build/jquery/jquery' . $min . '.js';
        $jqueryUI = $request->getBaseUrl() . '/js/build/jquery-ui/jquery-ui' . $min . '.js';
        $this->addScript('jQuery', $jquery, ['baseUrl' => '']);
        $this->addScript('jQueryUI', $jqueryUI, ['baseUrl' => '']);
        $this->addScript('jQueryTagIt', $request->getBaseUrl() . '/lib/pkp/js/lib/jquery/plugins/jquery.tag-it.js', ['baseUrl' => '']);

        // Load Bootstrap (includes Popper)
        $this->addScript('bootstrap', 'bootstrap/js/bootstrap.bundle.min.js');

        // Color mode switcher and other progressive enhancements
        $this->addScript('bootstrap5-theme', 'js/theme.js');

        // Add navigation menu areas for this theme
        $this->addMenuArea(['primary', 'user']);
    }

    /**
     * Get the display name of this plugin
     */
    public function getDisplayName(): string
    {
        return __('plugins.themes.bootstrap5.name');
    }

    /**
     * Get the description of this plugin
     */
    public function getDescription(): string
    {
        return __('plugins.themes.bootstrap5.description');
    }
}

if (!PKP_STRICT_MODE) {
    class_alias('\APP\plugins\themes\bootstrap5\Bootstrap5Plugin', '\Bootstrap5Plugin');
}
