{**
 * templates/frontend/components/pagination.tpl
 *
 * Copyright (c) 2014-2023 Simon Fraser University
 * Copyright (c) 2003-2023 John Willinsky
 * Modified (c) 2026 Irwan Daniel - Webmaxindo.com
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * @brief Common template for displaying pagination
 *
 * @uses $prevUrl string URL to the previous page
 * @uses $nextUrl string URL to the next page
 * @uses $showingStart int The number of the first item shown on this page
 * @uses $showingEnd int The number of the last item shown on this page
 * @uses $total int The total number of items available
 *}

{if $prevUrl || $nextUrl}
	<nav aria-label="{translate|escape key="common.pagination.label"}">
		<div class="d-flex flex-column flex-sm-row align-items-center justify-content-between gap-2">
			<p class="pagination-summary small text-body-secondary mb-0">
				{translate key="common.pagination" start=$showingStart end=$showingEnd total=$total}
			</p>
			<ul class="pagination mb-0">
				{if $prevUrl}
					<li class="page-item">
						<a class="page-link" href="{$prevUrl}" rel="prev" aria-label="{translate|escape key="help.previous"}">
							<span class="fa fa-angle-left" aria-hidden="true"></span>
							<span class="visually-hidden">{translate key="help.previous"}</span>
						</a>
					</li>
				{else}
					<li class="page-item disabled">
						<span class="page-link" aria-hidden="true">
							<span class="fa fa-angle-left"></span>
						</span>
					</li>
				{/if}
				{if $nextUrl}
					<li class="page-item">
						<a class="page-link" href="{$nextUrl}" rel="next" aria-label="{translate|escape key="help.next"}">
							<span class="fa fa-angle-right" aria-hidden="true"></span>
							<span class="visually-hidden">{translate key="help.next"}</span>
						</a>
					</li>
				{else}
					<li class="page-item disabled">
						<span class="page-link" aria-hidden="true">
							<span class="fa fa-angle-right"></span>
						</span>
					</li>
				{/if}
			</ul>
		</div>
	</nav>
{/if}
