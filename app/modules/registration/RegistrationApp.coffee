require './manual/login/RegistrationLogin'
require './manual/signUp/RegistrationSignUp'
require './manual/restore/RegistrationRestore'
require './manual/reset/RegistrationReset'

require './social/RegistrationSocial'

@App.module "RegistrationApp", (RegistrationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	app = angular.module('registration.signIn', ['registration.social', 'registration.login', 'registration.signUp', 'ngMaterial', 'ngMessages'])

	app.config ($httpProvider) ->
		$httpProvider.defaults.withCredentials = true

	API =
		registration: () ->
			AngularStarter.start(App.contentRegion, 'registration.signIn', require './registration')
		registrationManual: ->
			AngularStarter.start(App.contentRegion, 'registration.signIn', require './registration_manual')
		restore: ->
			AngularStarter.start(App.contentRegion, 'registration.restore', require './registration_restore')
		restoreSuccess: ->
			AngularStarter.start(App.contentRegion, 'registration.restore', require './registration_restore_success')
		reset: (token) ->
			AngularStarter.start(App.contentRegion, 'registration.reset', require './registration_reset')
		resetSuccess: () ->
			AngularStarter.start(App.contentRegion, 'registration.reset', require './registration_reset_success')
		signOut: () ->
			window.location.href = App.Utils.toUrl("registration", "signout")

	class RegistrationApp.Router extends Marionette.AppRouter
		appRoutes:
			'registration'                : 'registration'
			'registration/manual'         : 'registrationManual'
			'registration/restore'        : 'restore'
			'registration/restore/success': 'restoreSuccess'
			'registration/reset/success'  : 'resetSuccess'
			'registration/reset/:token'   : 'reset'
			'signout'                     : 'signOut'

	App.addInitializer ->
		new RegistrationApp.Router
			controller: API

