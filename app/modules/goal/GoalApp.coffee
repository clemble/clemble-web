require './configuration/GoalConfigurationApp'
require './construction/GoalConstructionApp'
require './initiation/GoalInitiationApp'
require './record/GoalRecordApp'

require './active/GoalActive'

require './show/GoalShow'

require './timeline/GoalTimeline'

@App.module "GoalApp", (GoalApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		showMy: ->
			App.request "goal:show:my", App.mainRegion

	class Router extends Marionette.AppRouter
		appRoutes:
			'goal': 'showMy'

	App.addInitializer ->
		new Router
			controller: API