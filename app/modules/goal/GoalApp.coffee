require './entities/GoalEntities'
require './pending/GoalPendingShow'
require './new/GoalNew'

require './status/GoalStatusApp'
require './bid/GoalBidApp'

require './judge/GoalJudgeApp'

@App.module "GoalApp", (GoalApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false