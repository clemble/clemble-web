require './RegistrationSocial.module'
require './RegistrationSocial.controller'

@App.module "RegistrationApp.RegistrationSocialApp", (RegistrationSocialApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	App.reqres.setHandler "registration:social:show", (region) -> AngularStarter.start(region, 'registration.social', require './templates/registration_show')