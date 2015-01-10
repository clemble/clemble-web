require './entities/GoalConfigurationEntities'
require './choice/GoalConfigurationChoice'
require './list/GoalConfigurationList'

@App.module "GoalApp.GoalConfigurationApp", (GoalConfigurationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		showMy: ->
			configurations = App.request "goal:configuration:entities:list"
			App.request "goal:configuration:list", configurations, App.contentRegion
		showChoice: ->
			choices = App.request "goal:configuration:entities:choice"
			App.request "goal:configuration:choice", choices, App.contentRegion

	class Router extends Marionette.AppRouter
		appRoutes:
			'configuration': 'showMy'
			'configuration/choice': 'showChoice'

	App.addInitializer ->
		new Router
			controller: API
