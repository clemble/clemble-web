@App.module "PlayerConnectionApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class PlayerConnection extends Backbone.Model
		parse: (res) ->
			{ player : res }

	class PlayerConnections extends Backbone.Collection
		model: PlayerConnection

	MY = new PlayerConnections()
	MY.url = App.Utils.toUrl("connection", "my")
	App.on "player:connection:add:my", (event) ->
		connection = new PlayerConnection({ player : event.connection })
		MY.add(connection)
	MY.fetch()
	App.once "registered", () -> MY.fetch()


	API =
		get: (player) ->
			if (player == 'my')
				MY
			else
				connection = new PlayerConnections()
				connection.url = App.Utils.toUrl("connection", "#{player}")
				connection.fetch()
				connection

	App.reqres.setHandler "player:connection:entities:my", () -> API.get('my')
	App.reqres.setHandler "player:connection:entities:get", (player) -> API.get(player)