require './entities/RegistrationEntities'
require './login/RegistrationLoginApp'
require './signUp/RegistrationSignUp'
require './social/RegistrationSocialApp'
require './show/RegistrationShow'
require './restore/RegistrationRestore'
require './reset/RegistrationReset'

@App.module "RegistrationApp", (RegistrationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		registration: ->
			App.request 'registration:show', App.contentRegion
		signUp: ->
			App.request 'registration:signUp:show', App.contentRegion
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
			'registration/signUp'         : 'signUp'
			'registration/restore'        : 'restore'
			'registration/restore/success': 'restoreSuccess'
			'registration/reset/success'  : 'resetSuccess'
			'registration/reset/:token'   : 'reset'

	App.addInitializer ->
		new RegistrationApp.Router
			controller: API