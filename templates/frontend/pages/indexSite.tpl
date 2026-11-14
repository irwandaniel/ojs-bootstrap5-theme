{**
 * templates/frontend/pages/indexSite.tpl
 *
 * Copyright (c) 2014-2023 Simon Fraser University
 * Copyright (c) 2003-2023 John Willinsky
 * Modified (c) 2026 Irwan Daniel - Webmaxindo.com
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * Site index.
 *
 *}
{include file="frontend/components/header.tpl"}

<div id="main-site" class="page_index_site">

	{if $about}
		<div class="about_site">
			{$about|nl2br}
		</div>
	{/if}

	{* Announcements *}
	{if $numAnnouncementsHomepage && $announcements|count}
		<section class="cmp_announcements">
			<header class="page-header">
				<h2>
					{translate key="announcement.announcements"}
				</h2>
			</header>
			<div class="d-flex flex-column gap-3">
				{foreach name=announcements from=$announcements item=announcement}
					{if $smarty.foreach.announcements.iteration > $numAnnouncementsHomepage}
						{break}
					{/if}
					{include file="frontend/objects/announcement_summary.tpl" heading="h3"}
				{/foreach}
			</div>
		</section>
	{/if}

	<div class="journals">
		<div class="page-header">
			<h2>
				{translate key="context.contexts"}
			</h2>
		</div>

		{if !count($journals)}
			<div class="no_journals">
				{translate key="site.noJournals"}
			</div>

		{else}
			<ul class="list-unstyled">
				{foreach from=$journals item=journal}
					{capture assign="url"}{url journal=$journal->getPath()}{/capture}
					{assign var="thumb" value=$journal->getLocalizedData('journalThumbnail')}
					{assign var="description" value=$journal->getLocalizedDescription()}
					<li class="card mb-3">
						<div class="card-body d-flex gap-3">
						{if $thumb}
							<div class="flex-shrink-0">
								<a href="{$url|escape}">
									<img class="img-fluid rounded" src="{$journalFilesPath}{$journal->getId()}/{$thumb.uploadName|escape:"url"}"{if $thumb.altText} alt="{$thumb.altText|escape}"{/if}>
								</a>
							</div>
						{/if}

						<div class="flex-grow-1">
							<h3 class="media-heading card-title">
								<a href="{$url|escape}" rel="bookmark">
									{$journal->getLocalizedName()}
								</a>
							</h3>
							{if $description}
								<div class="description">
									{$description|nl2br}
								</div>
							{/if}
							<ul class="nav nav-pills">
								<li class="nav-item view">
									<a class="nav-link" href="{$url|escape}">
										{translate key="site.journalView"}
									</a>
								</li>
								<li class="nav-item current">
									<a class="nav-link" href="{url|escape journal=$journal->getPath() page="issue" op="current"}">
										{translate key="site.journalCurrent"}
									</a>
								</li>
							</ul>
						</div>
						</div>
					</li>
				{/foreach}
			</ul>
		{/if}
	</div>

</div><!-- .page -->

{include file="frontend/components/footer.tpl"}
