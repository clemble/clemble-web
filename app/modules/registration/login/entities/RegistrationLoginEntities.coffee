@App.module "RegistrationLoginApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Login extends Backbone.Model
		defaults:
			emailOrNickName: ''
			password: ''
		initialize: () ->
			@listenTo(@, "sync", () ->
				App.trigger "registered"
				Backbone.history.navigate("goal", {trigger: true})
			)
		url:
			App.Utils.toUrl "/registration/login"
		validation:
			password: {
				required: true
				rangeLength: [6, 64]
			},
			emailOrNickName: {
				required: true
			}

	API =
		new: () ->
			login = new Login()
			login

	App.reqres.setHandler 'registration:login:entities:new', () -> API.new()
