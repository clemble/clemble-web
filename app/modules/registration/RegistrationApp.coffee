require './login/RegistrationLoginApp'
require './signUp/RegistrationSignUpApp'
require './social/RegistrationSocialApp'
require './show/RegistrationShow'
require './restore/RegistrationRestore'

@App.module "RegistrationApp", (RegistrationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		registration: ->
			App.request 'registration:show', App.contentRegion
		signUp: ->
			App.request 'registration:signUp:show', App.contentRegion
		restore: ->
			App.request 'registration:restore:show', App.contentRegion

	class RegistrationApp.Router extends Marionette.AppRouter
		appRoutes:
			'registration'            : 'registration'
			'registration/signUp'     : 'signUp'
			'registration/restore'    : 'restore'

	App.addInitializer ->
		new RegistrationApp.Router
			controller: API