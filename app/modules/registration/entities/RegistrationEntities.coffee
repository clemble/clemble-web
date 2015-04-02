@App.module "RegistrationApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class RegistrationRequest extends Backbone.Model
		initialize: () ->
			@listenTo(@, "sync", () ->
				console.log("sync triggered redirecting to goal page")
				App.trigger("registered")
				Backbone.history.navigate("goal", {trigger: true})
			)

	class LoginRequest extends RegistrationRequest
		defaults:
			emailOrNickName: ''
			password: ''
		url:
			App.Utils.toSubdomainUrl "registration", "/login"
		validation:
			password: {
				required: true
				rangeLength: [6, 64]
			},
			emailOrNickName: {
				required: true
			}

	class PlayerCredentials extends RegistrationRequest
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

	class PlayerRegistrationRequest extends RegistrationRequest
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
			App.Utils.toSubdomainUrl "registration", "/signin"
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
		newLogin: () ->
			login = new LoginRequest()
			login
		newCredentials: () ->
			credentials = new PlayerCredentials()
			credentials
		newRegistration: () ->
			registration = new PlayerRegistrationRequest()
			registration

	App.reqres.setHandler 'registration:entities:login:new', () -> API.newLogin()
	App.reqres.setHandler 'registration:entities:credentials:new', () -> API.newCredentials()
	App.reqres.setHandler 'registration:entities:registration:new', () -> API.newRegistration()
