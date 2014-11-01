require "./facebook/RegistrationSocialFacebook"

@App.module "RegistrationApp.RegistrationSocialApp", (RegistrationSocialApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false