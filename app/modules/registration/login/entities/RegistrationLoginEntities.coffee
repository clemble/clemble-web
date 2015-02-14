@App.module "RegistrationLoginApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Login extends Backbone.Model
		defaults:
			email: ''
			password: ''
		initialize: () ->
			@listenTo(@, "sync", () -> Backbone.history.navigate("goal", {trigger: true}))
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
			login.url = App.Utils.toUrl "/registration/base/login"
			login

	App.reqres.setHandler 'registration:login:entities:new', () -> API.new()
