@App.module "RegistrationBaseApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->


	class PlayerBaseRegistrationRequest extends Backbone.Model
		default:
			playerProfile: null
			playerCredential: null
		setPlayerCredential: (playerCredential) ->
			self = @
			self.set('playerCredential', playerCredential.attributes)
			@playerCredential = playerCredential
			@listenTo playerCredential, 'change', (model) ->
				self.set('playerCredential', model.attributes)
		setPlayerProfile: (playerProfile) ->
			self = @
			self.set('playerProfile', playerProfile.attributes)
			@playerProfile = playerProfile
			@listenTo playerProfile, 'change', (model) ->
				self.set('playerProfile', model.attributes)
		validate: () ->
			if (@playerCredential.isValid(true) && @playerProfile.isValid(true))
				undefined
			else
				"Request invalid"


	API =
		new: () ->
			login = App.request 'registration:login:entities:new'
			profile = App.request 'player:profile:entities:new'

			registrationRequest = new PlayerBaseRegistrationRequest()

			registrationRequest.setPlayerCredential login
			registrationRequest.setPlayerProfile profile

			registrationRequest.url = App.Utils.toUrl("/registration/base/signin")
			registrationRequest.on "all", (evt) -> console.log("registration > #{evt}")
			registrationRequest

	App.reqres.setHandler 'registration:base:entities:new', () -> API.new()