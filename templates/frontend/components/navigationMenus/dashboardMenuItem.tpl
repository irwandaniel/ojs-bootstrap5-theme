{**
 * templates/frontend/components/navigationMenus/dashboardMenuItem.tpl
 *
 * Copyright (c) 2014-2023 Simon Fraser University
 * Copyright (c) 2003-2023 John Willinsky
 * Modified (c) 2026 Irwan Daniel - Webmaxindo.com
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * @brief Dashboard menuItem Template
 *
 *}

{$navigationMenuItem->getLocalizedTitle()|escape}
<span class="badge text-bg-secondary">
	{$unreadNotificationCount}
</span>
