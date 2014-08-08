@App.module "PlayerProfileApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class PlayerProfile extends Backbone.Model
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
			profile = new PlayerProfile()
			profile.on "all", (evt) -> console.log("profile > #{evt}")
			profile
		get: (player) ->
			profile = new PlayerProfile(player: player)
			profile.url = "/player/profile/#{player}"
			profile.on "all", (evt) -> console.log("profile > #{evt}")
			profile.fetch()
			profile

	App.reqres.setHandler 'player:profile:entities:new', () -> API.new()

	App.reqres.setHandler 'player:profile:entities:my', () -> API.get('my')
	App.reqres.setHandler 'player:profile:entities:get', (player) -> API.get(player)

