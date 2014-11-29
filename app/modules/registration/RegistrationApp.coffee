require './login/RegistrationLoginApp'
require './signUp/RegistrationSignUpApp'
require './social/RegistrationSocialApp'
require './show/RegistrationShow'

@App.module "RegistrationApp", (RegistrationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		registration: ->
			App.request 'registration:show', App.contentRegion
		signUp: ->
			App.request 'registration:signUp:show', App.contentRegion

	class RegistrationApp.Router extends Marionette.AppRouter
		appRoutes:
			'registration'  : 'registration'
			'signUp'        : 'signUp'

	App.addInitializer ->
		new RegistrationApp.Router
			controller: API