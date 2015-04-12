@App.module "PlayerConnectionApp.List", (List, App, Backbone, Marionette, $, _) ->

	Controller =
		showMy: (region) ->
			connections = App.request "player:connection:entities:my"
			connectionsView = new PlayerConnections
				collection: connections
			region.show connectionsView

	class PlayerConnection extends Marionette.ItemView
		template: require './templates/connection'
		className : 'row'
		modelEvents:
			sync    : 'render'
		behaviors:
			BootstrapTooltip: {}
			ClickPlayer: {}
		events    :
			'click #suggest' : 'suggest'
			'click #player'  : 'playerModal'
		suggest: () ->
			url = App.Utils.toUrl("suggestion", "player/#{@model.get('player')}")
			App.request "goal:suggestion:new:modal", url
		playerModal: () ->
			App.request "player:show:modal", @model.get('player')

	class PlayerConnections extends Marionette.CompositeView
		template: require './templates/connections'
		childView: PlayerConnection
		childViewContainer: "#content"
		events:
			"click #connect": () -> App.request "player:connection:invitation:new:modal"

	App.reqres.setHandler "player:connection:show:my", (region) -> Controller.showMy(region)
