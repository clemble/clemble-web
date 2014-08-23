require './entities/GoalJudgeDutyEntities'
require './pending/GoalJudgeDutyPending'

@App.module "GoalJudgeDutyApp", (GoalJudgeDutyApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false