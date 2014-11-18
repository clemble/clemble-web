@App.module "PlayerConnectionApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		showMy: (region) ->
			connections = App.request "player:connection:entities:my"
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
		childViewContainer: "#content"

	App.reqres.setHandler "player:connection:show:my", (region) -> Controller.showMy(region)
