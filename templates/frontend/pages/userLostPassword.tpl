{**
 * templates/frontend/pages/userLostPassword.tpl
 *
 * Copyright (c) 2014-2023 Simon Fraser University
 * Copyright (c) 2000-2023 John Willinsky
 * Modified (c) 2026 Irwan Daniel - Webmaxindo.com
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * Password reset form.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login.resetPassword"}

<div id="main-content" class="page page_lost_password">

	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.login"}

	<div class="bs5-auth">
		<div class="bs5-auth-card">
			<header class="bs5-auth-header">
				<h1 class="bs5-auth-title">{translate key="user.login.resetPassword"}</h1>
			</header>

			<div class="alert alert-info" role="alert">
				{translate key="user.login.resetPasswordInstructions"}
			</div>

			{if $error}
				<div class="alert alert-danger" role="alert">
					{translate key=$error}
				</div>
			{/if}

			<form class="pkp_form lost_password" id="lostPasswordForm" action="{url page="login" op="requestResetPassword"}" method="post">
				{csrf}

				<div class="mb-4">
					<label class="form-label" for="login-email">
						{translate key="user.login.registeredEmail"}
					</label>
					<input type="email" name="email" class="form-control" id="login-email" placeholder="{translate key='user.login.registeredEmail'}" value="{$email|escape}" maxlength="90" autocomplete="email" required>
				</div>

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
					<button type="submit" class="btn btn-primary btn-lg">
						{translate key="user.login.resetPassword"}
					</button>
					<a class="btn btn-outline-secondary" href="{url page="login"}">
						{translate key="plugins.themes.bootstrap5.backToLogin"}
					</a>
				</div>
			</form>

			{if !$disableUserReg}
				<p class="bs5-auth-links">
					{capture assign="registerUrl"}{url page="user" op="register" source=$source}{/capture}
					<a href="{$registerUrl}">
						{translate key="user.login.registerNewAccount"}
					</a>
				</p>
			{/if}
		</div>
	</div>
</div><!-- .page -->

{include file="common/frontend/footer.tpl"}
