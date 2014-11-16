require './configuration/GoalConfigurationApp'
require './construction/GoalConstructionApp'
require './initiation/GoalInitiationApp'
require './record/GoalRecordApp'
require './timeline/GoalTimelineApp'

require './active/GoalActive'
require './show/GoalShow'

require './listener/GoalListenerApp'

@App.module "GoalApp", (GoalApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		showMy: ->
			App.request "goal:show:my", App.contentRegion

	class Router extends Marionette.AppRouter
		appRoutes:
			'goal': 'showMy'

	App.addInitializer ->
		new Router
			controller: API