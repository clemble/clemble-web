require './entities/GoalConfigurationEntities'
require './list/GoalConfigurationList'

@App.module "GoalApp.GoalConfigurationApp", (GoalConfigurationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		showMy: ->
			configurations = App.request "goal:configuration:entities:all"
			App.request "goal:configuration:list", configurations, App.contentRegion

	class Router extends Marionette.AppRouter
		appRoutes:
			'configuration': 'showMy'

	App.addInitializer ->
		new Router
			controller: API
