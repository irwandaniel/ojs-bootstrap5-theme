{**
 * templates/frontend/objects/article_summary.tpl
 *
 * Copyright (c) 2014-2024 Simon Fraser University Library
 * Copyright (c) 2003-2024 John Willinsky
 * Modified (c) 2026 Irwan Daniel - ([Webmaxindo](http://www.webmaxindo.com/))
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * @brief View of an Article summary which is shown within a list of articles.
 *
 * @uses $article Article The article
 * @uses $authorUserGroups Traversible The set of author user groups
 * @uses $hasAccess bool Can this user access galleys for this context? The
 *       context may be an issue or an article
 * @uses $showGalleyLinks bool Show galley links to users without access?
 * @uses $hideGalleys bool Hide the article galleys for this article?
 * @uses $primaryGenreIds array List of file genre ids for primary file types
 *}
{assign var=publication value=$article->getCurrentPublication()}
{assign var=articlePath value=$article->getBestId($currentJournal)}
{if (!$section.hideAuthor && $publication->getData('hideAuthor') == \APP\submission\Submission::AUTHOR_TOC_DEFAULT) || $publication->getData('hideAuthor') == \APP\submission\Submission::AUTHOR_TOC_SHOW}
	{assign var="showAuthor" value=true}
{/if}

<div class="card article-summary my-2">
	<div class="card-body d-flex gap-3">
	{if $publication->getLocalizedData('coverImage')}
		{assign var="coverImage" value=$publication->getLocalizedData('coverImage')}
		<div class="cover flex-shrink-0">
			<a href="{if $journal}{url journal=$journal->getPath() page="article" op="view" path=$articlePath}{else}{url page="article" op="view" path=$articlePath}{/if}" class="file">
				<img class="img-fluid rounded" src="{$publication->getLocalizedCoverImageUrl($currentContext->getId())|escape}" alt="{$coverImage.altText|escape|default:''}">
			</a>
		</div>
	{/if}

	<div class="flex-grow-1">
		<h3 class="media-heading card-title">
            <a href="{if $journal}{url journal=$journal->getPath() page="article" op="view" path=$articlePath}{else}{url page="article" op="view" path=$articlePath}{/if}">
				{$publication->getLocalizedTitle()|strip_unsafe_html}
				{if $publication->getLocalizedSubtitle()}
					<p>
						<small>{$publication->getLocalizedSubtitle()|escape}</small>
					</p>
				{/if}
			</a>
		</h3>

		{if $showAuthor || $publication->getData('pages')}

			{if $showAuthor}
				<div class="meta">
					{if $showAuthor}
						<div class="authors">
							{$publication->getAuthorString($authorUserGroups)|escape}
						</div>
					{/if}
				</div>
			{/if}

			{* Page numbers for this article *}
			{if $publication->getData('pages')}
				<p class="pages">
					{$publication->getData('pages')|escape}
				</p>
			{/if}

		{/if}

		{if !$hideGalleys && $article->getGalleys()}
			
				{foreach from=$article->getGalleys() item=galley}
					{if $primaryGenreIds}
						{assign var="file" value=$galley->getFile()}
						{if !$galley->getData('urlRemote') && !($file && in_array($file->getGenreId(), $primaryGenreIds))}
							{continue}
						{/if}
					{/if}
					{assign var=publication value=$article->getCurrentPublication()}
					{assign var="hasArticleAccess" value=$hasAccess}
					{if $currentContext->getSetting('publishingMode') == \APP\journal\Journal::PUBLISHING_MODE_OPEN || $publication->getData('accessStatus') == \APP\submission\Submission::ARTICLE_ACCESS_OPEN}
						{assign var="hasArticleAccess" value=1}
					{/if}
					{include file="frontend/objects/galley_link.tpl" parent=$article hasAccess=$hasArticleAccess}
				{/foreach}
			
		{/if}
	</div><!-- .flex-grow-1 -->

		{call_hook name="Templates::Issue::Issue::Article"}
	</div><!-- .card-body -->
</div><!-- .article-summary -->
