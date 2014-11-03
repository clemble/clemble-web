@App.module "RegistrationLoginApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Login extends Backbone.Model
		defaults:
			email: ''
			password: ''
		validation:
			password: {
				required: true
				rangeLength: [6, 64]
			},
			email: {
				required: true,
				pattern: 'email'
			}

	API =
		new: () ->
			login = new Login()
			login.on "all", (evt) -> console.log("login > #{evt}") # TODO make a single point to intercept all initiations, and listen for events
			login.url = App.Utils.toUrl "/registration/base/login"
			login

	App.reqres.setHandler 'registration:login:entities:new', () -> API.new()
