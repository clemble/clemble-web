@App.module "ProfileApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Profile extends Backbone.Model
		defaults:
			player            : null #TODO check that it can't be assigned manually during creation
			nickName          : null
			firstName         : null
			lastName          : null
			gender            : null
			birthDate         : null
			socialConnections : []   #TODO check that it can't be assigned manually
		idAttribute: 'player'

	API =
		new: () ->
			profile = new Profile()
			profile.on "all", (evt) -> console.log("profile > #{evt}")
			profile

	App.reqres.setHandler 'profile:entities:new', () -> API.new()

