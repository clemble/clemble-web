require './RegistrationSocial.module'
require './RegistrationSocial.controller'
require './RegistrationSocial.directive'

@App.module "RegistrationApp.RegistrationSocialApp", (RegistrationSocialApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	App.reqres.setHandler "registration:social:show", (region) -> AngularStarter.start(region, 'registration.social', require './templates/registration_show')