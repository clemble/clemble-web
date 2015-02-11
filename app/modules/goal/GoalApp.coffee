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
		navigateGoal: ->
			Backbone.history.navigate("goal", {trigger: true})

	class Router extends Marionette.AppRouter
		appRoutes:
			'': 'navigateGoal'
			'_=_': 'navigateGoal'
			'goal': 'showMy'

	App.addInitializer ->
		new Router
			controller: API