@App.module "RegistrationApp.RegistrationSocialApp.Facebook", (Facebook, App, Backbone, Marionette, $, _) ->

	Controller =
		socialRegistration: (region) ->
			registrationView = new SocialRegistration
				model: new Backbone.Model(host: window.location.host)
			region.show registrationView

	class SocialRegistration extends Marionette.ItemView
		template: require './templates/registration_show'
		events:
			"click .btn" : "socialLogin"
		socialLogin: (evt) ->
			signin = evt.currentTarget.getAttribute("signin")
			if(signin == "manual")
				console.log("Manual sign in")
			else
				signinUrl = App.Utils.toUrl("/social/signin/#{signin}")
				$("<form action='#{signinUrl}' method='post'></form>").submit();

	App.reqres.setHandler "registration:social:show", (region) -> Controller.socialRegistration(region)