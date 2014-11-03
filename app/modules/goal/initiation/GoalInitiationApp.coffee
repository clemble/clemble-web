require './entities/GoalInitiationEntities'
require './list/GoalInitiationList'

@App.module "GoalApp.GoalInitiationApp", (GoalInitiationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		listMy: () ->
			App.request "goal:initiation:list:my", App.contentRegion

	class Router extends Marionette.AppRouter
		appRoutes:
			'goal/initiation/my': 'listMy'

	App.addInitializer ->
		new Router
			controller: API