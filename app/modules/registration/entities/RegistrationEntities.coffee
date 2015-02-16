@App.module "RegistrationApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class PlayerCredentials extends Backbone.Model
		defaults:
			email: ''
			password: ''
		initialize: () ->
			@listenTo(@, "sync", () ->
				App.trigger "registered"
				Backbone.history.navigate("goal", {trigger: true})
			)
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
			credentials = new PlayerCredentials()
			credentials

	App.reqres.setHandler 'registration:entities:credentials:new', () -> API.new()
