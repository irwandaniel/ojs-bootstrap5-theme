{**
 * templates/frontend/pages/userRegister.tpl
 *
 * Copyright (c) 2014-2023 Simon Fraser University
 * Copyright (c) 2003-2023 John Willinsky
 * Modified (c) 2026 Irwan Daniel - Webmaxindo.com
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * User registration form.
 *}
{include file="frontend/components/header.tpl" pageTitle="user.register"}

{assign var="siteContextId" value=PKP\core\PKPApplication::SITE_CONTEXT_ID|intval}

<div id="main-content" class="page page_register">

	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.register"}

	<div class="bs5-auth bs5-auth-wide">
		<header class="bs5-auth-header">
			<h1 class="bs5-auth-title">{translate key="user.register"}</h1>
			<p class="bs5-auth-subtitle">{translate key="common.requiredField"}</p>
		</header>

		<form class="pkp_form register" id="register" method="post" action="{url op="register"}">
			{csrf}

			{if $source}
				<input type="hidden" name="source" value="{$source|escape}" />
			{/if}

			{include file="common/formErrors.tpl"}

			{include file="frontend/components/registrationForm.tpl"}

			{* When a user is registering with a specific journal *}
			{if $currentContext}

				<fieldset class="bs5-form-section consent">
					<legend>
						{translate key="plugins.themes.bootstrap5.consent"}
					</legend>

					{if $currentContext->getSetting('privacyStatement')}
						{* Require the user to agree to the terms of the privacy policy *}
						<div class="mb-3 optin optin-privacy">
							<div class="form-check">
								<input class="form-check-input" type="checkbox" name="privacyConsent" id="privacyConsent" value="1"{if $privacyConsent} checked="checked"{/if}>
								{capture assign="privacyUrl"}{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="about" op="privacy"}{/capture}
								<label class="form-check-label" for="privacyConsent">
									{translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
								</label>
							</div>
						</div>
					{/if}

					{* Ask the user to opt into public email notifications *}
					<div class="optin optin-email">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" name="emailConsent" id="emailConsent" value="1"{if $emailConsent} checked="checked"{/if}>
							<label class="form-check-label" for="emailConsent">
								{translate key="user.register.form.emailConsent"}
							</label>
						</div>
					</div>
				</fieldset>

				{* Allow the user to sign up as a reviewer *}
				{assign var=contextId value=$currentContext->getId()}
				{assign var=userCanRegisterReviewer value=0}
				{foreach from=$reviewerUserGroups[$contextId] item=userGroup}
					{if $userGroup->permitSelfRegistration}
						{assign var=userCanRegisterReviewer value=$userCanRegisterReviewer+1}
					{/if}
				{/foreach}
				{if $userCanRegisterReviewer}
					<fieldset class="bs5-form-section reviewer">
						<legend>
							{translate key="user.reviewerPrompt"}
						</legend>
						{if $userCanRegisterReviewer > 1}
							{capture assign="checkboxLocaleKey"}user.reviewerPrompt.userGroup{/capture}
						{else}
							{capture assign="checkboxLocaleKey"}user.reviewerPrompt.optin{/capture}
						{/if}
						<div class="fields">
							<div id="reviewerOptinGroup" class="mb-3 optin d-flex flex-column gap-2">
								{foreach from=$reviewerUserGroups[$contextId] item=userGroup}
									{if $userGroup->permitSelfRegistration}
										{assign var="userGroupId" value=$userGroup->id}
										<div class="form-check">
											<input class="form-check-input" type="checkbox" name="reviewerGroup[{$userGroupId}]" id="reviewerGroup[{$userGroupId}]" value="1"{if in_array($userGroupId, $userGroupIds)} checked="checked"{/if}>
											<label class="form-check-label" for="reviewerGroup[{$userGroupId}]">
												{translate key=$checkboxLocaleKey userGroup=$userGroup->getLocalizedData('name')|escape}
											</label>
										</div>
									{/if}
								{/foreach}
							</div>
							<div id="reviewerInterests" class="mb-0 reviewer_interests">
								<label class="form-label" for="interests">
									{translate key="user.interests"}
								</label>
								<input class="form-control" type="text" name="interests" id="interests" value="{$interests|default:""|escape}">
							</div>
						</div>
					</fieldset>
				{/if}
			{/if}

			{include file="frontend/components/registrationFormContexts.tpl"}

			{if !$currentContext}
				<fieldset class="bs5-form-section consent">
					<legend>
						{translate key="plugins.themes.bootstrap5.consent"}
					</legend>

					{* Require the user to agree to the terms of the privacy policy *}
					{if $siteWidePrivacyStatement}
						<div class="mb-3 optin optin-privacy">
							<div class="form-check">
								<input class="form-check-input" type="checkbox" name="privacyConsent[{$siteContextId}]" id="privacyConsent[{$siteContextId}]" value="1"{if $privacyConsent[$siteContextId]} checked="checked"{/if}>
								{capture assign="privacyUrl"}{url router=\PKP\core\PKPApplication::ROUTE_PAGE page="about" op="privacy"}{/capture}
								<label class="form-check-label" for="privacyConsent[{$siteContextId}]">
									{translate key="user.register.form.privacyConsent" privacyUrl=$privacyUrl}
								</label>
							</div>
						</div>
					{/if}

					{* Ask the user to opt into public email notifications *}
					<div class="mb-3 optin optin-email">
						<div class="form-check">
							<input class="form-check-input" type="checkbox" name="emailConsent" id="emailConsent" value="1"{if $emailConsent} checked="checked"{/if}>
							<label class="form-check-label" for="emailConsent">
								{translate key="user.register.form.emailConsent"}
							</label>
						</div>
					</div>

					{* When a user is registering for no specific journal, allow them to enter their reviewer interests *}
					<div class="mb-0 reviewer_nocontext_interests">
						<label class="form-label" for="interests">
							{translate key="user.register.noContextReviewerInterests"}
						</label>
						<input class="form-control" type="text" name="interests" id="interests" value="{$interests|default:""|escape}">
					</div>
				</fieldset>
			{/if}

			{* recaptcha spam blocker *}
			{if $recaptchaPublicKey}
				<fieldset class="recaptcha_wrapper mb-3">
					<div class="fields">
						<div class="recaptcha">
							<div class="g-recaptcha" data-sitekey="{$recaptchaPublicKey|escape}">
							</div>
						</div>
					</div>
				</fieldset>
			{/if}

			{* altcha spam blocker *}
			{if $altchaEnabled}
				<fieldset class="altcha_wrapper mb-3">
					<div class="fields">
						<altcha-widget challengejson='{$altchaChallenge|@json_encode}' floating></altcha-widget>
					</div>
				</fieldset>
			{/if}

			<div class="bs5-auth-actions">
				<button class="btn btn-primary btn-lg submit" type="submit">
					{translate key="user.register"}
				</button>

				{capture assign="rolesProfileUrl"}{url page="user" op="profile" path="roles"}{/capture}
				<a class="btn btn-outline-secondary login" href="{url page="login" source=$rolesProfileUrl}">
					{translate key="user.login"}
				</a>
			</div>
		</form>
	</div>
</div><!-- .page -->

{include file="common/frontend/footer.tpl"}
