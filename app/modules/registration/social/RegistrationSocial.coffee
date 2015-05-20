require './RegistrationSocial.module'
require './RegistrationSocial.controller'
require './RegistrationSocial.directive'

@App.module "RegistrationApp.RegistrationSocialApp", (RegistrationSocialApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false