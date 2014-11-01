
@App.module "RegistrationApp.RegistrationSocialApp.Facebook", (Facebook, App, Backbone, Marionette, $, _) ->

	Controller =
		facebookRegistration: (region) ->
			registrationView = new FacebookRegistration
				model: new Backbone.Model(host: window.location.host)
			region.show registrationView

	class FacebookRegistration extends Marionette.ItemView
		template: require './templates/registration_facebook'

	App.reqres.setHandler "registration:social:facebook", (region) -> Controller.facebookRegistration(region)