@App.module "PlayerConnectionApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class PlayerConnection extends Backbone.Model
		parse: (res) ->
			{ player : res }

	class PlayerConnections extends Backbone.Collection
		model: PlayerConnection

	API =
		get: (player) ->
			account = new PlayerConnections()
			account.url = App.Utils.toUrl("/connection/#{player}")
			account.fetch()
			account

	App.reqres.setHandler "player:connection:entities:my", () -> API.get('my')
	App.reqres.setHandler "player:connection:entities:get", (player) -> API.get(player)