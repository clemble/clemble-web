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
		validate: (attrs) ->
			@playerCredential.isValid(true)


	API =
		new: (login, profile) ->
			registrationRequest = new PlayerBaseRegistrationRequest()

			registrationRequest.setPlayerCredential login

			registrationRequest.listenTo profile, 'change', (model) ->
				registrationRequest.set('playerProfile', model.attributes)

			registrationRequest.url = App.Utils.toUrl("/registration/base/signin")
			registrationRequest.on "all", (evt) -> console.log("registration > #{evt}")
			registrationRequest

	App.reqres.setHandler 'registration:base:entities:new', (login, profile) -> API.new(login, profile)