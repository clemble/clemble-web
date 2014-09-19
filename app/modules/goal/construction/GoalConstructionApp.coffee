require './entities/GoalConstructionEntities'
require './new/GoalConstructionNew'

@App.module "GoalConstructionApp", (GoalConstructionApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		constructNew: ->
			configurations = App.request("goal:configuration:entities:all")
			App.request "goal:construction:new", configurations, App.mainRegion

	class Router extends Marionette.AppRouter
		appRoutes:
			'goal/construction/my': 'constructNew'

	App.addInitializer ->
		new Router
			controller: API