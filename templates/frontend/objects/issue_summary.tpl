{**
 * templates/frontend/objects/issue_summary.tpl
 *
 * Copyright (c) 2014-2023 Simon Fraser University
 * Copyright (c) 2003-2023 John Willinsky
 * Modified (c) 2026 Irwan Daniel - ([Webmaxindo](http://www.webmaxindo.com/))
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * @brief View of an Issue which displays a summary for use in lists
 *
 * @uses $issue Issue The issue
 *}
{assign var="hasCover" value=$issue->getLocalizedCoverImage()}
{assign var=issueTitle value=$issue->getLocalizedTitle()}
{assign var=issueSeries value=$issue->getIssueSeries()}
{assign var=issueDescription value=$issue->getLocalizedDescription()}

<div class="card issue-summary mb-3">
	<div class="row g-0">

		{* Horizontal card: cover on the start side, details on the end side *}
		{if $hasCover}
			<div class="col-md-4">
				<a class="cover d-block" href="{url page="issue" op="view" path=$issue->getBestIssueId($currentJournal)}">
					<img
						src="{$issue->getLocalizedCoverImageUrl()|escape}"
						class="img-fluid rounded-start"
						alt="{$issue->getLocalizedCoverImageAltText()|escape|default:''}"
						loading="lazy">
				</a>
			</div>
		{/if}

		<div class="{if $hasCover}col-md-8{else}col-12{/if}">
			<div class="card-body">
				<h5 class="card-title">
					<a class="title" href="{url page="issue" op="view" path=$issue->getBestIssueId($currentJournal)}">
						{if $issueTitle}
							{$issueTitle|escape}
						{else}
							{$issueSeries|escape}
						{/if}
					</a>
				</h5>

				{if $issueDescription}
					{* Kept as a div so formatted issue descriptions (links, paragraphs) stay valid HTML *}
					<div class="description card-text">
						{$issueDescription|strip_unsafe_html|nl2br}
					</div>
				{/if}

				{if ($issueTitle && $issueSeries) || $issue->getDatePublished()}
					<p class="card-text">
						<small class="text-body-secondary">
							{if $issueTitle && $issueSeries}{$issueSeries|escape}{/if}
							{if $issueTitle && $issueSeries && $issue->getDatePublished()} &middot; {/if}
							{if $issue->getDatePublished()}
								{translate key="submissions.published"}
								{$issue->getDatePublished()|date_format:$dateFormatShort}
							{/if}
						</small>
					</p>
				{/if}
			</div><!-- .card-body -->
		</div>
	</div><!-- .row -->
</div><!-- .issue-summary -->
