@App.module "PlayerConnectionApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		show: (player, region) ->
			connections = App.request("player:connection:entities:get", player)
			connectionsView = new PlayerConnections
				collection: connections
			region.show connectionsView


	class PlayerConnection extends Marionette.ItemView
		template: require './templates/connection'
		modelEvents:
			sync: 'render'

	class PlayerConnections extends Marionette.CompositeView
		template: require './templates/connections'
		childView: PlayerConnection
		childViewContainer: 'div'

	App.reqres.setHandler "player:connection:show", (player, region) -> Controller.show(player, region)
