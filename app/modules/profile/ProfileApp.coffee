require './entities/ProfileEntities'
require './new/ProfileNew'
require './show/ProfileShow'

@App.module "ProfileApp", (PlayerProfileApp, App, Backbone, Marionette, $, _) ->
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