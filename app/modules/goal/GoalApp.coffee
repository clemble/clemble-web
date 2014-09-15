require './entities/GoalEntities'
require './pending/GoalPendingShow'
require './new/GoalNew'

require './status/GoalStatusApp'
require './bid/GoalBidApp'

require './judge/GoalJudgeApp'

require './timeline/GoalTimeline'

@App.module "GoalApp", (GoalApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		showMy: ->
			App.request "goal:timeline:my", App.mainRegion

	class Router extends Marionette.AppRouter
		appRoutes:
			'goal': 'showMy'

	App.addInitializer ->
		new Router
			controller: API