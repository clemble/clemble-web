require './entities/GoalJudgeInvitationEntities'
require './list/GoalJudgeInvitationList'

@App.module "GoalJudgeInvitationApp", (GoalJudgeInvitationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false