require './entities/GoalEntities'
require './pending/GoalPendingShow'
require './new/GoalNew'

require './status/GoalStatusApp'
require './bid/GoalBidApp'

require './judge/GoalJudgeApp'

require './configuration/GoalConfigurationApp'
require './timeline/GoalTimeline'

@App.module "GoalApp", (GoalApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		showMy: ->
			configurations = App.request("goal:configuration:entities:get")
			App.request "goal:configuration:list", configurations, App.mainRegion

	class Router extends Marionette.AppRouter
		appRoutes:
			'goal': 'showMy'

	App.addInitializer ->
		new Router
			controller: API