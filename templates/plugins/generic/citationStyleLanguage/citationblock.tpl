{**
 * templates/plugins/generic/citationStyleLanguage/citationblock.tpl
 *
 * Copyright (c) 2014-2024 Simon Fraser University
 * Copyright (c) 2003-2024 John Willinsky
 * Modified (c) 2026 Irwan Daniel - ([Webmaxindo](http://www.webmaxindo.com/))
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *}
{if $citation}
    <div class="card how-to-cite">
        <div class="card-header">
            <h2 class="card-title">
                {translate key="submission.howToCite"}
            </h2>
        </div>
        <div class="card-body">
            <div id="citationOutput" role="region" aria-live="polite">
                {$citation}
            </div>
            <div class="btn-group">
                <button type="button" class="btn btn-outline-secondary dropdown-toggle" data-bs-toggle="dropdown">
                    {translate key="submission.howToCite.citationFormats"}
                </button>
                <ul class="dropdown-menu" role="menu">
                    {foreach from=$citationStyles item="citationStyle"}
                        <li>
                            <a
                                    class="dropdown-item"
                                    rel="nofollow"
                                    aria-controls="citationOutput"
                                    href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgs}"
                                    data-load-citation
                                    data-json-href="{url page="citationstylelanguage" op="get" path=$citationStyle.id params=$citationArgsJson}"
                            >
                                {$citationStyle.title|escape}
                            </a>
                        </li>
                    {/foreach}
                </ul>
            </div>
            {if count($citationDownloads)}
                <div class="btn-group">
                    <button type="button" class="btn btn-outline-secondary dropdown-toggle" data-bs-toggle="dropdown">
                        {translate key="submission.howToCite.downloadCitation"}
                    </button>
                    {* Download citation formats *}
                    <ul class="dropdown-menu" role="menu">
                        {foreach from=$citationDownloads item="citationDownload"}
                        <li>
                            <a class="dropdown-item" href="{url page="citationstylelanguage" op="download" path=$citationDownload.id params=$citationArgs}">
                                <span class="fa fa-download"></span>
                                {$citationDownload.title|escape}
                            </a>
                        </li>
                        {/foreach}
                    </ul>
                </div>
            {/if}
        </div>
    </div>
{/if}
