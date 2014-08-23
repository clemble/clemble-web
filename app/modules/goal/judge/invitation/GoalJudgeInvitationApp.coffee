require './entities/GoalJudgeInvitationEntities'
require './list/GoalJudgeInvitationList'
require './pending/GoalJudgeInvitationPending'

@App.module "GoalJudgeInvitationApp", (GoalJudgeInvitationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false