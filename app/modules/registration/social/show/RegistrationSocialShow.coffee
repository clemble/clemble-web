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
		google: "
				<input type='hidden' name='scope' value='email https://www.googleapis.com/auth/plus.login https://www.googleapis.com/auth/plus.me https://www.googleapis.com/auth/tasks https://www.googleapis.com/auth/drive https://www.googleapis.com/auth/latitude.all.best' />
				<input type='hidden' name='request_visible_actions' value='http://schemas.google.com/AddActivity http://schemas.google.com/BuyActivity http://schemas.google.com/CheckInActivity http://schemas.google.com/CommentActivity http://schemas.google.com/CreateActivity http://schemas.google.com/DiscoverActivity http://schemas.google.com/ListenActivity http://schemas.google.com/ReserveActivity http://schemas.google.com/ReviewActivity http://schemas.google.com/WantActivity'/>
				<input type='hidden' name='access_type' value='offline'/>
			"
		socialLogin: (evt) =>
			signin = evt.currentTarget.getAttribute("signin")
			signinUrl = App.Utils.toUrl("/social/signin/#{signin}")
			if(@[signin]?)
				$("<form action='#{signinUrl}' method='post'>#{@[signin]}</form>").submit();
			else
				$("<form action='#{signinUrl}' method='post'></form>").submit();

	App.reqres.setHandler "registration:social:show", (region) -> Controller.socialRegistration(region)