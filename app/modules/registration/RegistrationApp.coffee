require './manual/login/RegistrationLogin'
require './manual/signUp/RegistrationSignUp'
require './manual/restore/RegistrationRestore'
require './manual/reset/RegistrationReset'

require './social/RegistrationSocial'

@App.module "RegistrationApp", (RegistrationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		registration: ->
			App.request 'registration:show', App.contentRegion
		registrationManual: ->
			App.request 'registration:show:manual', App.contentRegion
		restore: ->
			App.request 'registration:restore:show', App.contentRegion
		restoreSuccess: ->
			App.request 'registration:restore:show:success', App.contentRegion
		reset: (token) ->
			App.request 'registration:reset:show', App.contentRegion, token
		resetSuccess: () ->
			App.request 'registration:reset:show:success', App.contentRegion

	class RegistrationApp.Router extends Marionette.AppRouter
		appRoutes:
			'registration'                : 'registration'
			'registration/manual'         : 'registrationManual'
			'registration/restore'        : 'restore'
			'registration/restore/success': 'restoreSuccess'
			'registration/reset/success'  : 'resetSuccess'
			'registration/reset/:token'   : 'reset'

	App.addInitializer ->
		new RegistrationApp.Router
			controller: API

	app = angular.module('registration.signIn', ['registration.social', 'registration.login', 'registration.signUp', 'ngMaterial', 'ngMessages'])

	app.config ($httpProvider) ->
		$httpProvider.defaults.withCredentials = true

	App.reqres.setHandler 'registration:show', (region) -> AngularStarter.start(region, 'registration.signIn', require './registration')
	App.reqres.setHandler 'registration:show:manual', (region) -> AngularStarter.start(region, 'registration.signIn', require './registration_manual')
