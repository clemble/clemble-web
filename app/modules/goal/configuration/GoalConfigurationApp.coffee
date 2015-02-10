require './entities/GoalConfigurationEntities'
require './choice/GoalConfigurationChoice'
require './interval/GoalConfigurationInterval'
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
		showInterval: ->
			interval = App.request "goal:configuration:entities:interval"
			App.request "goal:configuration:interval", interval, App.contentRegion

	class Router extends Marionette.AppRouter
		appRoutes:
			'configuration': 'showMy'
			'configuration/choice': 'showChoice'
			'configuration/interval': 'showInterval'

	App.addInitializer ->
		new Router
			controller: API
