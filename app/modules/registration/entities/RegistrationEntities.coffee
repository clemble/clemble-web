@App.module "RegistrationApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->


	class PlayerRegistrationRequest extends Backbone.Model
		default:
			playerProfile: null
			playerCredential: null

	API =
		new: (login, profile) ->
			registrationRequest = new PlayerRegistrationRequest()
			registrationRequest.listenTo login, 'change', (model) ->
				registrationRequest.set('playerCredential', model.attributes)
			registrationRequest.listenTo profile, 'change', (model) ->
				registrationRequest.set('playerProfile', model.attributes)
			registrationRequest.url = "/player/registration/base/signin"
			registrationRequest.on "all", (evt) -> console.log("registration > #{evt}")
			registrationRequest

	App.reqres.setHandler 'registration:entities:new', (login, profile) -> API.new(login, profile)