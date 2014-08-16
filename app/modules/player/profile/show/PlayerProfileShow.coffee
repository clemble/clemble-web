@App.module "PlayerProfileApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		show: (player, region) ->
			playerLayout = new Layout()
			playerLayout.on "show", () ->
				player = App.request "player:profile:entities:get", player
				playerView = new Player
					model: player
				playerLayout.profileRegion.show playerView
				App.request "player:account:show:my", playerLayout.accountRegion
			region.show playerLayout

	class Layout extends Marionette.LayoutView
		template: require './templates/layout'
		regions:
			profileRegion   : '#profileRegion'
			accountRegion   : '#accountRegion'


	class Player extends Marionette.ItemView
		template: require "./templates/profile"
		modelEvents:
			'sync' : 'render'

	App.reqres.setHandler "player:profile:show", (player, region) -> Controller.show(player, region)
	App.reqres.setHandler "player:profile:show:my", (region) -> Controller.show('my', region)