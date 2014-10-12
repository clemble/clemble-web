require './entities/GoalEntities'
require './pending/GoalPendingShow'

require './status/GoalStatusApp'
require './bid/GoalBidApp'

require './judge/GoalJudgeApp'

require './configuration/GoalConfigurationApp'
require './construction/GoalConstructionApp'
require './initiation/GoalInitiationApp'
require './record/GoalRecordApp'

require './timeline/GoalTimeline'

@App.module "GoalApp", (GoalApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		showMy: ->
#			configurations = App.request("goal:configuration:entities:all")
#			App.request "goal:construction:new", configurations, App.mainRegion
			App.request "goal:initiation:list:my", App.mainRegion

	class Router extends Marionette.AppRouter
		appRoutes:
			'goal': 'showMy'

	App.addInitializer ->
		new Router
			controller: API