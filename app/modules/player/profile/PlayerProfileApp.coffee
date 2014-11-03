require './entities/PlayerProfileEntities'
require './new/PlayerProfileNew'
require './show/PlayerProfileShow'

@App.module "PlayerApp.PlayerProfileApp", (PlayerProfileApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		showMy: ->
			App.request "player:profile:show:my", App.contentRegion

	class Router extends Marionette.AppRouter
		appRoutes:
			'player/profile': 'showMy'

	App.addInitializer ->
		new Router
			controller: API