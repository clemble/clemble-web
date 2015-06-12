require './account.module'
require './account.service'
require './account.controller'
require './account.directive'

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