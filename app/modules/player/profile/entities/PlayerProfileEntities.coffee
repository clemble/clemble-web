@App.module "PlayerProfileApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class PlayerProfile extends Backbone.Model
		defaults:
			player            : '' #TODO check that it can't be assigned manually during creation
			nickName          : ''
			firstName         : ''
			lastName          : ''
			gender            : null
			birthDate         : ''
			socialConnections : []   #TODO check that it can't be assigned manually
		idAttribute: 'player'
		validation: {
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
		}
		parse: (res) ->
			connected = {

			}
			missing = {
				"facebook"  : ""
				"twitter"   : ""
				"vkontakte" : ""
				"google"    : ""
			}
			res.socialConnections.forEach((connection) ->
				connected[connection.providerId] = connection.providerUserId
				delete missing connection.providerId
			)
			res.connected = connected
			res.missing = missing
			res

	API =
		new: () ->
			profile = new PlayerProfile()
			profile.on "all", (evt, descr) -> console.log("profile > #{evt} > #{JSON.stringify(descr)}")
			profile
		get: (player) ->
			profile = new PlayerProfile(player: player)
			profile.url = App.Utils.toUrl("/profile/#{player}")
			profile.on "all", (evt, descr) -> console.log("profile > #{evt} > #{JSON.stringify(descr)}")
			profile.fetch()
			profile

	App.reqres.setHandler 'player:profile:entities:new', () -> API.new()

	App.reqres.setHandler 'player:profile:entities:my', () -> API.get('my')
	App.reqres.setHandler 'player:profile:entities:get', (player) -> API.get(player)

