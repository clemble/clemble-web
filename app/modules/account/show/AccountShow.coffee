@App.module "AccountApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		show: (player, region) ->
			account = App.request "account:entities:get", player
			accountShow = new AccountShow
				model: account
			region.show accountShow
		showNav: (player, region) ->
			account = App.request "account:entities:get", player
			accountShow = new AccountShowNavigation
				model: account
			region.show accountShow
		showNavMobile: (player, region) ->
			account = App.request "account:entities:get", player
			accountShow = new ccountShowNavigationMobile
				model: account
			region.show accountShow

	class AccountShow extends Marionette.ItemView
		template: require './templates/account'
		modelEvents:
			'sync'    : 'render'
			'change'  : 'render'

	class AccountShowNavigation extends Marionette.ItemView
		template: require './templates/account_nav'
		modelEvents:
			'sync'    : 'render'
			'change'  : 'render'

	class ccountShowNavigationMobile extends Marionette.ItemView
		template: require './templates/account_nav_mobile'
		modelEvents:
			'sync'    : 'render'
			'change'  : 'render'

	App.reqres.setHandler "account:show", (player, region) -> Controller.show(player, region)
	App.reqres.setHandler "account:show:my", (region) -> Controller.show('my', region)
	App.reqres.setHandler "account:show:my:nav", (region) -> Controller.showNav('my', region)
	App.reqres.setHandler "account:show:my:nav:mobile", (region) -> Controller.showNavMobile('my', region)