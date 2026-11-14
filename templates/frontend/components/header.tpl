{**
 * lib/pkp/templates/frontend/components/header.tpl
 *
 * Copyright (c) 2014-2023 Simon Fraser University
 * Copyright (c) 2003-2023 John Willinsky
 * Modified (c) 2026 Irwan Daniel - ([Webmaxindo](http://www.webmaxindo.com/))
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * @brief Common frontend site header.
 *
 * @uses $isFullWidth bool Should this page be displayed without sidebars? This
 *       represents a page-level override, and doesn't indicate whether or not
 *       sidebars have been configured for thesite.
 *}

{* Determine whether a logo or title string is being displayed *}
{assign var="showingLogo" value=true}
{if $displayPageHeaderTitle && !$displayPageHeaderLogo && is_string($displayPageHeaderTitle)}
	{assign var="showingLogo" value=false}
{/if}

{* Color mode. The initial attribute is rendered on the server so that the
   first paint already matches the configured default. The inline script in
   headerHead.tpl and js/theme.js take over for visitors who chose a mode. *}
{assign var="colorMode" value='auto'}
{if $activeTheme && $activeTheme->getOption('colorMode')}
	{assign var="colorMode" value=$activeTheme->getOption('colorMode')}
{/if}
{assign var="initialColorMode" value='light'}
{if $colorMode === 'dark'}
	{assign var="initialColorMode" value='dark'}
{/if}

<!DOCTYPE html>
<html lang="{$currentLocale|replace:"_":"-"}" xml:lang="{$currentLocale|replace:"_":"-"}" dir="{$currentLocaleLangDir|escape|default:"ltr"}" data-bs-theme="{$initialColorMode}" data-color-mode-default="{$colorMode|escape}" data-color-mode-preference="{$colorMode|escape}">
{if !$pageTitleTranslated}{capture assign="pageTitleTranslated"}{translate key=$pageTitle}{/capture}{/if}
{include file="frontend/components/headerHead.tpl"}
<body class="pkp_page_{$requestedPage|escape|default:"index"} pkp_op_{$requestedOp|escape|default:"index"}{if $showingLogo} has_site_logo{/if}" dir="{$currentLocaleLangDir|escape|default:"ltr"}">
	<div class="pkp_structure_page">

		<nav id="accessibility-nav" class="visually-hidden" role="navigation" aria-label="{translate|escape key="plugins.themes.bootstrap5.accessible_menu.label"}">
			<ul>
			  <li><a href="#main-navigation">{translate|escape key="plugins.themes.bootstrap5.accessible_menu.main_navigation"}</a></li>
			  <li><a href="#main-content">{translate|escape key="plugins.themes.bootstrap5.accessible_menu.main_content"}</a></li>
			  <li><a href="#sidebar">{translate|escape key="plugins.themes.bootstrap5.accessible_menu.sidebar"}</a></li>
			</ul>
		</nav>

		{* Header. Uses the Bootstrap 5 navbar pattern: brand, toggler and a
		   single collapse that holds the primary navigation, the search form
		   and the user menu. *}
		<header class="navbar navbar-expand-xl sticky-xl-top bg-body-tertiary" id="headerNavigationContainer" role="banner">
			<div class="container pkp_head_wrapper">

				{* Logo or site title. Only use <h1> heading on the homepage.
				   Otherwise that should go to the page title. *}
				{if $requestedOp == 'index'}
					<h1 class="site-name mb-0">
				{else}
					<div class="site-name">
				{/if}
					{capture assign="homeUrl"}{url page="index" router=\PKP\core\PKPApplication::ROUTE_PAGE}{/capture}
					{if $displayPageHeaderLogo}
						<a href="{$homeUrl}" class="navbar-brand navbar-brand-logo d-flex align-items-center">
							<img src="{$publicFilesDir}/{$displayPageHeaderLogo.uploadName|escape:"url"}" {if $displayPageHeaderLogo.altText != ''}alt="{$displayPageHeaderLogo.altText|escape}"{/if}>
						</a>
					{elseif $displayPageHeaderTitle}
						<a href="{$homeUrl}" class="navbar-brand">{$displayPageHeaderTitle}</a>
					{else}
						<a href="{$homeUrl}" class="navbar-brand">
							<img src="{$baseUrl}/templates/images/structure/logo.png" alt="{$applicationName|escape}" title="{$applicationName|escape}" />
						</a>
					{/if}
				{if $requestedOp == 'index'}
					</h1>
				{else}
					</div>
				{/if}

				{* Mobile navigation toggler *}
				<button class="navbar-toggler ms-auto" type="button" data-bs-toggle="collapse" data-bs-target="#nav-menu" aria-controls="nav-menu" aria-expanded="false" aria-label="{translate|escape key="plugins.themes.bootstrap5.accessible_menu.toggle"}">
					<span class="navbar-toggler-icon"></span>
				</button>

				{* Primary site navigation *}
				{capture assign="primaryMenu"}
					{load_menu name="primary" id="main-navigation" ulClass="navbar-nav me-auto mb-2 mb-lg-0"}
				{/capture}

				<div id="nav-menu" class="collapse navbar-collapse">
					<nav class="d-lg-flex align-items-lg-center w-100" aria-label="{translate|escape key="common.navigation.site"}">
						{$primaryMenu}

						{* Search form *}
						{if $currentContext}
							<div class="navbar-search my-2 my-lg-0 ms-lg-3">
								{include file="frontend/components/searchForm_simple.tpl"}
							</div>
						{/if}

						{* User menu and color mode switcher *}
						<div class="navbar-user d-flex align-items-center flex-wrap gap-2 mt-3 mt-lg-0 ms-lg-3">
							<nav class="navbar-user-nav" aria-label="{translate|escape key="common.navigation.user"}">
								{load_menu name="user" id="navigationUser" ulClass="navbar-nav"}
							</nav>

							<div class="dropdown color-mode-switcher">
								<button class="btn btn-sm btn-outline-secondary dropdown-toggle" type="button" id="colorModeToggle" data-bs-toggle="dropdown" aria-expanded="false">
									<span class="color-mode-icon color-mode-icon-light" aria-hidden="true"><span class="fa fa-sun-o"></span></span>
									<span class="color-mode-icon color-mode-icon-dark" aria-hidden="true"><span class="fa fa-moon-o"></span></span>
									<span class="color-mode-icon color-mode-icon-auto" aria-hidden="true"><span class="fa fa-adjust"></span></span>
									<span class="visually-hidden">{translate key="plugins.themes.bootstrap5.colorMode.label"}</span>
								</button>
								<ul class="dropdown-menu dropdown-menu-end" aria-labelledby="colorModeToggle">
									<li>
										<button type="button" class="dropdown-item" data-bs-theme-value="light" aria-pressed="false">
											<span class="fa fa-sun-o" aria-hidden="true"></span>
											{translate key="plugins.themes.bootstrap5.colorMode.light"}
											<span class="fa fa-check color-mode-check invisible" aria-hidden="true"></span>
										</button>
									</li>
									<li>
										<button type="button" class="dropdown-item" data-bs-theme-value="dark" aria-pressed="false">
											<span class="fa fa-moon-o" aria-hidden="true"></span>
											{translate key="plugins.themes.bootstrap5.colorMode.dark"}
											<span class="fa fa-check color-mode-check invisible" aria-hidden="true"></span>
										</button>
									</li>
									<li>
										<button type="button" class="dropdown-item" data-bs-theme-value="auto" aria-pressed="false">
											<span class="fa fa-adjust" aria-hidden="true"></span>
											{translate key="plugins.themes.bootstrap5.colorMode.auto"}
											<span class="fa fa-check color-mode-check invisible" aria-hidden="true"></span>
										</button>
									</li>
								</ul>
							</div>
						</div>
					</nav>
				</div>

			</div><!-- .container -->
		</header><!-- .pkp_structure_head -->

		{* Wrapper for page content and sidebars *}
		<div class="pkp_structure_content container pt-4">
			<div class="row">
			<main class="pkp_structure_main {if empty($isFullWidth)}col-12 col-sm-10 col-md-9{else}col-12{/if}" role="main">
