{**
 * templates/frontend/pages/userLogin.tpl
 *
 * Copyright (c) 2014-2023 Simon Fraser University
 * Copyright (c) 2000-2023 John Willinsky
 * Modified (c) 2026 Irwan Daniel - ([Webmaxindo](http://www.webmaxindo.com/))
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * User login form.
 *
 *}
{include file="frontend/components/header.tpl" pageTitle="user.login"}

<div id="main-content" class="page page_login">

	{include file="frontend/components/breadcrumbs.tpl" currentTitleKey="user.login"}

	<div class="bs5-auth">
		<div class="bs5-auth-card">
			<header class="bs5-auth-header">
				<h1 class="bs5-auth-title">{translate key="user.login"}</h1>
			</header>

			{* A login message may be displayed if the user was redirected to the
			   login page from another request. Examples include if login is required
			   before downloading a file. *}
			{if $loginMessage}
				<div class="alert alert-info" role="alert">
					{translate key=$loginMessage}
				</div>
			{/if}

			{if $error}
				<div class="alert alert-danger" role="alert">
					{translate key=$error reason=$reason}
				</div>
			{/if}

			<form class="pkp_form login" id="login" method="post" action="{$loginUrl}">
				{csrf}
				<input type="hidden" name="source" value="{$source|strip_unsafe_html|escape}" />

				<div class="mb-3">
					<label class="form-label" for="login-username">
						{translate key="user.username"}
					</label>
					<input type="text" name="username" class="form-control" id="login-username" placeholder="{translate key='user.username'}" value="{$username|default:""|escape}" maxlength="32" autocomplete="username" autocapitalize="none" spellcheck="false" required>
				</div>

				<div class="mb-3">
					<div class="d-flex align-items-center justify-content-between gap-2">
						<label class="form-label mb-0" for="login-password">
							{translate key="user.password"}
						</label>
						<a class="small" href="{url page="login" op="lostPassword"}">
							{translate key="user.login.forgotPassword"}
						</a>
					</div>
					<div class="input-group mt-1">
						<input type="password" name="password" class="form-control" id="login-password" placeholder="{translate key='user.password'}" password="true" maxlength="32" autocomplete="current-password" required>
						<button class="btn btn-outline-secondary" type="button"
							data-toggle-password="login-password"
							data-label-show="{translate key="plugins.themes.bootstrap5.showPassword"}"
							data-label-hide="{translate key="plugins.themes.bootstrap5.hidePassword"}"
							aria-label="{translate key="plugins.themes.bootstrap5.showPassword"}"
							aria-pressed="false">
							<span class="fa fa-eye" aria-hidden="true"></span>
						</button>
					</div>
				</div>

				<div class="form-check mb-4">
					<input class="form-check-input" type="checkbox" name="remember" id="remember" value="1" checked="$remember">
					<label class="form-check-label" for="remember">
						{translate key="user.login.rememberUsernameAndPassword"}
					</label>
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
						{translate key="user.login"}
					</button>

					{if !$disableUserReg}
						{capture assign="registerUrl"}{url page="user" op="register" source=$source}{/capture}
						<a class="btn btn-outline-secondary register-button" href="{$registerUrl}" role="button">
							{translate key="user.login.registerNewAccount"}
						</a>
					{/if}
				</div>
			</form>
		</div>
	</div>
</div><!-- .page -->

{include file="common/frontend/footer.tpl"}
