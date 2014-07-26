@App.module "RegistrationApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->


	class PlayerRegistrationRequest extends Backbone.Model
		default:
			playerProfile: null
			playerCredential: null

	API =
		new: () ->
			registrationRequest = new PlayerRegistrationRequest()
			registrationRequest.on "all", (evt) -> console.log("registration > #{evt}")
			registrationRequest

	App.reqres.setHandler 'profile:entities:new', () -> API.new()