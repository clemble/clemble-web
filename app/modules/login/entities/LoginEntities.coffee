@App.module "LoginApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Login extends Backbone.Model
		defaults:
			email: ''
			password: ''

	API =
		new: () ->
			login = new Login()
			login.on "all", (evt) -> console.log("login > #{evt}") # TODO make a single point to intercept all initiations, and listen for events
			login.url = "/player/registration/base/login"
			login

	App.reqres.setHandler 'login:entities:new', () -> API.new()
