@App.module "ProfileApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		show: (player, region) ->
			player = App.request "profile:entities:get", player
			playerView = new Player
				model: player
			region.show playerView

	class Player extends Marionette.ItemView
		template: require "./templates/profile"
		modelEvents:
			'sync'   : 'render'
			'change' : 'render'
		events:
			'click #phone' : () -> App.request "player:phone:new:modal"

	App.reqres.setHandler "profile:show", (player, region) -> Controller.show(player, region)
	App.reqres.setHandler "profile:show:my", (region) -> Controller.show('my', region)