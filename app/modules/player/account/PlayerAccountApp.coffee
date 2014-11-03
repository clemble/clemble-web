require './entities/PlayerAccountEntities'
require './show/PlayerAccountShow'

@App.module "PlayerApp.PlayerAccountApp", (PlayerAccountApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		showMy: ->
			App.request "player:account:show:my", App.contentRegion

	class Router extends Marionette.AppRouter
		appRoutes:
			'player/account': 'showMy'

	App.addInitializer ->
		new Router
			controller: API