require './entities/GoalRecordEntities'
require './list/GoalRecordList'

@App.module "GoalApp.GoalRecordApp", (GoalRecordApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		listMy: () ->
			App.request "goal:record:list:my", App.mainRegion

	class Router extends Marionette.AppRouter
		appRoutes:
			'goal/record/my': 'listMy'

	App.addInitializer ->
		new Router
			controller: API