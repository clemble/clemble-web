require './registration.social.module'
require './registration.social.controller'
require './registration.social.directive'

@App.module "RegistrationApp.RegistrationSocialApp", (RegistrationSocialApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false