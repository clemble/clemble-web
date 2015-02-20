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
		urlRoot: () ->
			App.Utils.toUrl("/profile/")
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
				delete missing[connection.providerId]
			)
			res.connected = connected
			res.missing = missing
			res

	MY = new PlayerProfile({ player: 'my' })
	MY.fetch()
	App.once "registered", () -> MY.fetch()

	API =
		new: () ->
			profile = new PlayerProfile()
			profile
		get: (player) ->
			if (player == "my")
				MY
			profile = new PlayerProfile(player: player)
			profile.url = App.Utils.toUrl("/profile/#{player}")
			App.on "player:profile:changed:my", (event) ->
				profile.set(event.playerProfile)
			profile.fetch()
			profile

	App.reqres.setHandler 'player:profile:entities:new', () -> API.new()
	App.reqres.setHandler 'player:profile:entities:my', () -> API.get('my')
	App.reqres.setHandler 'player:profile:entities:get', (player) -> API.get(player)
	App.reqres.setHandler 'player:profile:entities:my:social': () -> MY.get('socialConnections')

