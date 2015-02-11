require './configuration/GoalConfigurationApp'
require './construction/GoalConstructionApp'
require './record/GoalRecordApp'

require './active/GoalActive'
require './show/GoalShow'
require './suggestion/GoalSuggestionApp'

require './listener/GoalListenerApp'

@App.module "GoalApp", (GoalApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		showMy: ->
			App.request "goal:show:my", App.contentRegion

	class Router extends Marionette.AppRouter
		appRoutes:
			'': 'showMy'
			'goal': 'showMy'

	App.addInitializer ->
		new Router
			controller: API