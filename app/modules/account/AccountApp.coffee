require './entities/AccountEntities'
require './show/AccountShow'

@App.module "AccountApp", (AccountApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		showMy: ->
			App.request "account:show:my", App.contentRegion

	class Router extends Marionette.AppRouter
		appRoutes:
			'player/account': 'showMy'

	App.addInitializer ->
		new Router
			controller: API