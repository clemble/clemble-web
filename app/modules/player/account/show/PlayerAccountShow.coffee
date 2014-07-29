@App.module "PlayerAccountApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		get: (player, region) ->
			account = App.request "player:account:entities:get", player
			accountShow = new PlayerAccountShow
				model: account
			region.show accountShow

	class PlayerAccountShow extends Marionette.ItemView
		template: require './templates/account'
		modelEvents:
			sync: 'render'

	App.reqres.setHandler "player:account:show", (player, region) -> Controller.get(player, region)