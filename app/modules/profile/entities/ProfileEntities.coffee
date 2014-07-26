@App.module "ProfileApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Profile extends Backbone.Model
		defaults:
			player    : ''  #TODO check that it can't be assigned manually during creation
			country   : ''
			type      : 'free' #TODO check that it can't be assigned manually
			nickName  : ''
			firstName : 'A'
			lastName  : 'B'
			gender    : ''
			birthDate : ''
			category  : 'Novice' #TODO check that it can't be assigned manually
			socialConnections: [] #TODO check that it can't be assigned manually
		idAttribute: 'player'

	API =
		new: () ->
			profile = new Profile()
			profile.on "all", (evt) -> console.log("profile > #{evt}")
			profile

	App.reqres.setHandler 'profile:entities:new', () -> API.new()

