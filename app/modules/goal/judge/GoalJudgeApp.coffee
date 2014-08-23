require './invitation/GoalJudgeInvitationApp'
require './duties/GoalJudgeDutyApp'

@App.module "GoalJudgeApp", (GoalJudgeApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false