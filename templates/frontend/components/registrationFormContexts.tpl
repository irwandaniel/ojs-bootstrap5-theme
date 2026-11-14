{**
 * templates/frontend/components/registrationFormContexts.tpl
 *
 * Copyright (c) 2014-2023 Simon Fraser University
 * Copyright (c) 2003-2023 John Willinsky
 * Modified (c) 2026 Irwan Daniel - ([Webmaxindo](http://www.webmaxindo.com/))
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * @brief Display role selection for all of the journals/presses on this site
 *
 * @uses $contexts array List of journals/presses on this site
 * @uses $readerUserGroups array Associative array of user groups with reader
 *  permissions in each context.
 * @uses $authorUserGroups array Associative array of user groups with author
 *  permissions in each context.
 * @uses $reviewerUserGroups array Associative array of user groups with reviewer
 *  permissions in each context.
 * @uses $userGroupIds array List group IDs this user is assigned
 *}

{* Only display the context role selection when registration is taking place
   outside of the context of any one journal/press. *}
{if !$currentContext}

	<fieldset class="bs5-form-section contexts">
		<legend>
			{translate key="user.register.contextsPrompt"}
		</legend>
		<div class="d-flex flex-column gap-3">
			{foreach from=$contexts item=context}
				{assign var=contextId value=$context->getId()}
				{assign var=isSelected value=false}
				<div class="card bs5-context-card">
					<div class="card-body">
						<h3 class="h5 card-title">
							{$context->getLocalizedName()}
						</h3>
						<p class="card-text small text-body-secondary">
							{translate key="user.register.otherContextRoles"}
						</p>

						<div class="d-flex flex-column gap-2 context_roles">
							{foreach from=$readerUserGroups[$contextId] item=userGroup}
								{if $userGroup->permitSelfRegistration}
									{assign var="userGroupId" value=$userGroup->id}
									<div class="form-check">
										<input class="form-check-input" type="checkbox" name="readerGroup[{$userGroupId}]" id="readerGroup[{$userGroupId}]"{if in_array($userGroupId, $userGroupIds)} checked="checked"{/if}>
										<label class="form-check-label" for="readerGroup[{$userGroupId}]">
											{$userGroup->getLocalizedData('name')|escape}
										</label>
									</div>
									{if in_array($userGroupId, $userGroupIds)}
										{assign var=isSelected value=true}
									{/if}
								{/if}
							{/foreach}
							{foreach from=$reviewerUserGroups[$contextId] item=userGroup}
								{if $userGroup->permitSelfRegistration}
									{assign var="userGroupId" value=$userGroup->id}
									<div class="form-check">
										<input class="form-check-input" type="checkbox" name="reviewerGroup[{$userGroupId}]" id="reviewerGroup[{$userGroupId}]"{if in_array($userGroupId, $userGroupIds)} checked="checked"{/if}>
										<label class="form-check-label" for="reviewerGroup[{$userGroupId}]">
											{$userGroup->getLocalizedData('name')|escape}
										</label>
									</div>
									{if in_array($userGroupId, $userGroupIds)}
										{assign var=isSelected value=true}
									{/if}
								{/if}
							{/foreach}
						</div>

						{* Require the user to agree to the terms of the context's privacy policy *}
						{if !$enableSiteWidePrivacyStatement && $context->getSetting('privacyStatement')}
							<div class="context_privacy mt-3 {if $isSelected}context_privacy_visible{/if}">
								<div class="form-check">
									<input class="form-check-input" type="checkbox" name="privacyConsent[{$contextId}]" id="privacyConsent[{$contextId}]" value="1"{if $privacyConsent[$contextId]} checked="checked"{/if}>
									{capture assign="privacyUrl"}{url router=\PKP\core\PKPApplication::ROUTE_PAGE context=$context->getPath() page="about" op="privacy"}{/capture}
									<label class="form-check-label" for="privacyConsent[{$contextId}]">
										{translate key="user.register.form.privacyConsentThisContext" privacyUrl=$privacyUrl}
									</label>
								</div>
							</div>
						{/if}
					</div>
				</div>
			{/foreach}
		</div>
	</fieldset>
{/if}
