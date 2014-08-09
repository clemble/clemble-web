require './login/RegistrationLoginApp'
require './base/RegistrationBaseApp'

@App.module "RegistrationApp", (RegistrationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		login: ->
			App.request 'registration:base:show', App.mainRegion

	class RegistrationApp.Router extends Marionette.AppRouter
		appRoutes:
			'login' : 'login'

	App.addInitializer ->
		new RegistrationApp.Router
			controller: API