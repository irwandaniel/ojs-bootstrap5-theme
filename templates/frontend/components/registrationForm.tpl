{**
 * templates/frontend/components/registrationForm.tpl
 *
 * Copyright (c) 2014-2023 Simon Fraser University
 * Copyright (c) 2003-2023 John Willinsky
 * Modified (c) 2026 Irwan Daniel - ([Webmaxindo](http://www.webmaxindo.com/))
 * Distributed under the GNU GPL v3. For full terms see the file LICENSE.
 *
 * @brief Display the basic registration form fields
 *
 * @uses $locale string Locale key to use in the affiliate field
 * @uses $firstName string First name input entry if available
 * @uses $middleName string Middle name input entry if available
 * @uses $lastName string Last name input entry if available
 * @uses $countries array List of country options
 * @uses $country string The selected country if available
 * @uses $email string Email input entry if available
 * @uses $username string Username input entry if available
 *}
<fieldset class="bs5-form-section identity">
	<legend>
		{translate key="user.profile"}
	</legend>
	<div class="row g-3">
		<div class="col-md-6 given_name">
			<label class="form-label" for="givenName">
				{translate key="user.givenName"}
				<span class="form-control-required" aria-hidden="true">*</span>
				<span class="visually-hidden">{translate key="common.required"}</span>
			</label>
			<input class="form-control" type="text" name="givenName" id="givenName" value="{$givenName|escape}" maxlength="255" autocomplete="given-name" required>
		</div>
		<div class="col-md-6 family_name">
			<label class="form-label" for="familyName">
				{translate key="user.familyName"}
			</label>
			<input class="form-control" type="text" name="familyName" id="familyName" value="{$familyName|escape}" maxlength="255" autocomplete="family-name">
		</div>
		<div class="col-12 affiliation">
			<label class="form-label" for="affiliation">
				{translate key="user.affiliation"}
				<span class="form-control-required" aria-hidden="true">*</span>
				<span class="visually-hidden">{translate key="common.required"}</span>
			</label>
			<input class="form-control" type="text" name="affiliation" id="affiliation" value="{$affiliation|escape}" autocomplete="organization" required>
		</div>
		<div class="col-md-6 country">
			<label class="form-label" for="country">
				{translate key="common.country"}
				<span class="form-control-required" aria-hidden="true">*</span>
				<span class="visually-hidden">{translate key="common.required"}</span>
			</label>
			<select class="form-select" name="country" id="country" autocomplete="country" required>
				<option></option>
				{html_options options=$countries selected=$country}
			</select>
		</div>
	</div>
</fieldset>

<fieldset class="bs5-form-section login">
	<legend>
		{translate key="user.login"}
	</legend>
	<div class="row g-3">
		<div class="col-12 email">
			<label class="form-label" for="email">
				{translate key="user.email"}
				<span class="form-control-required" aria-hidden="true">*</span>
				<span class="visually-hidden">{translate key="common.required"}</span>
			</label>
			<input class="form-control" type="email" name="email" id="email" value="{$email|escape}" maxlength="90" autocomplete="email" required>
		</div>
		<div class="col-md-6 username">
			<label class="form-label" for="username">
				{translate key="user.username"}
				<span class="form-control-required" aria-hidden="true">*</span>
				<span class="visually-hidden">{translate key="common.required"}</span>
			</label>
			<input class="form-control" type="text" name="username" id="username" value="{$username|escape}" maxlength="32" autocomplete="username" autocapitalize="none" spellcheck="false" required>
		</div>
		<div class="col-md-6 password">
			<label class="form-label" for="password">
				{translate key="user.password"}
				<span class="form-control-required" aria-hidden="true">*</span>
				<span class="visually-hidden">{translate key="common.required"}</span>
			</label>
			<div class="input-group">
				<input class="form-control" type="password" name="password" id="password" password="true" maxlength="32" autocomplete="new-password" required>
				<button class="btn btn-outline-secondary" type="button"
					data-toggle-password="password"
					data-label-show="{translate key="plugins.themes.bootstrap5.showPassword"}"
					data-label-hide="{translate key="plugins.themes.bootstrap5.hidePassword"}"
					aria-label="{translate key="plugins.themes.bootstrap5.showPassword"}"
					aria-pressed="false">
					<span class="fa fa-eye" aria-hidden="true"></span>
				</button>
			</div>
		</div>
		<div class="col-md-6 password">
			<label class="form-label" for="password2">
				{translate key="user.repeatPassword"}
				<span class="form-control-required" aria-hidden="true">*</span>
				<span class="visually-hidden">{translate key="common.required"}</span>
			</label>
			<div class="input-group">
				<input class="form-control" type="password" name="password2" id="password2" password="true" maxlength="32" autocomplete="new-password" required>
				<button class="btn btn-outline-secondary" type="button"
					data-toggle-password="password2"
					data-label-show="{translate key="plugins.themes.bootstrap5.showPassword"}"
					data-label-hide="{translate key="plugins.themes.bootstrap5.hidePassword"}"
					aria-label="{translate key="plugins.themes.bootstrap5.showPassword"}"
					aria-pressed="false">
					<span class="fa fa-eye" aria-hidden="true"></span>
				</button>
			</div>
		</div>
	</div>
</fieldset>
