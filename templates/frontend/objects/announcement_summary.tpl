{**
 * templates/frontend/objects/announcement_summary.tpl
 *
 * Copyright (c) 2014-2024 Simon Fraser University Library
 * Copyright (c) 2003-2024 John Willinsky
 * Modified (c) 2026 Irwan Daniel - ([Webmaxindo](http://www.webmaxindo.com/))
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * @brief Display a summary view of an announcement
 *
 * @uses $announcement Announcement The announcement to display
 *}
<article class="card announcement-summary my-1">
	<div class="card-body">
		<h2 class="media-heading card-title">
			<a href="{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="announcement" op="view" path=$announcement->id}">
				{$announcement->getLocalizedData('title')|escape}
			</a>
		</h2>
		<p class="date">
			<span class="fa fa-calendar"></span>
			{$announcement->datePosted->format($dateFormatShort)|escape}
		</p>
		{$announcement->getLocalizedData('descriptionShort')|strip_unsafe_html}
	</div>
</article><!-- .announcement-summary -->
