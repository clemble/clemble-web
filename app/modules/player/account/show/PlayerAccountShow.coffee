@App.module "PlayerAccountApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		show: (player, region) ->
			account = App.request "player:account:entities:get", player
			accountShow = new PlayerAccountShow
				model: account
			region.show accountShow
		showNav: (player, region) ->
			account = App.request "player:account:entities:get", player
			accountShow = new PlayerAccountShowNavigation
				model: account
			region.show accountShow

	class PlayerAccountShow extends Marionette.ItemView
		template: require './templates/account'
		modelEvents:
			'sync'    : 'render'
			'change'  : 'render'

	class PlayerAccountShowNavigation extends Marionette.ItemView
		template: require './templates/account_nav'
		modelEvents:
			'sync'    : 'render'
			'change'  : 'render'

	App.reqres.setHandler "player:account:show", (player, region) -> Controller.show(player, region)
	App.reqres.setHandler "player:account:show:my", (region) -> Controller.show('my', region)
	App.reqres.setHandler "player:account:show:my:nav", (region) -> Controller.showNav('my', region)