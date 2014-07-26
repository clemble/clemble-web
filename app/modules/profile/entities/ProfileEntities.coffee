@App.module "ProfileApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Profile extends Backbone.Model
		default:
			player: null  #TODO check that it can't be assigned manually during creation
			country: null
			type: 'free' #TODO check that it can't be assigned manually
			nickName: null
			firstName: null
			lastName: null
			gender: null
			birthDate: null
			imageUrl: null
			category: 'Novice' #TODO check that it can't be assigned manually
			socialConnections: [] #TODO check that it can't be assigned manually
		idAttribute: 'player'

	API =
		new: () ->
			profile = new Profile()
			profile.on "all", (evt) -> console.log("login > #{evt}")
			profile

	App.reqres.setHandler 'profile:entities:new', () -> API.new()

