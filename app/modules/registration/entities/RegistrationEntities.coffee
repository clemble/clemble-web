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

	class PlayerRegistrationRequest extends Backbone.Model
		defaults:
			player            : ''
			email             : ''
			password          : ''
			player            : ''
			nickName          : ''
			firstName         : ''
			lastName          : ''
			gender            : null
			birthDate         : ''
		url: () ->
			App.Utils.toUrl "/registration/signin"
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
			nickName: {
				maxLength: 64
			}
			firstName: {
				maxLength: 64
			}
			lastName: {
				maxLength: 64
			}
			gender: {
				oneOf: [null, 'M', 'W']
			}

	API =
		newCredentials: () ->
			credentials = new PlayerCredentials()
			credentials
		newRegistration: () ->
			registration = new PlayerRegistrationRequest()
			registration

	App.reqres.setHandler 'registration:entities:credentials:new', () -> API.newCredentials()
	App.reqres.setHandler 'registration:entities:registration:new', () -> API.newRegistration()
