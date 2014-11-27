@App.module "PlayerProfileApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		show: (player, region) ->
			player = App.request "player:profile:entities:get", player
			playerView = new Player
				model: player
			region.show playerView

	class Player extends Marionette.ItemView
		template: require "./templates/profile"
		modelEvents:
			'sync' : 'render'
		events:
			"click #add": () -> App.request "goal:construction:my:new:modal"


	App.reqres.setHandler "player:profile:show", (player, region) -> Controller.show(player, region)
	App.reqres.setHandler "player:profile:show:my", (region) -> Controller.show('my', region)