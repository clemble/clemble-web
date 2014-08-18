require './invitation/GoalJudgeInvitationApp'

@App.module "GoalJudgeApp", (GoalJudgeApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false