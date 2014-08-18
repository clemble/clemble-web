@App.module "GoalJudgeInvitationApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class GoalJudgeInvitation extends Backbone.Model
		defaults:
			goalKey : null
			player  : null
			judge   : null
			goal    : null
			status  : null

	class GoalJudgeInvitations extends Backbone.Collection
		model: GoalJudgeInvitation

	API =
		all: (player) ->
			invitations = new GoalJudgeInvitations()
			invitations.url = "/goal/judge/invitations/my/"
			invitations.fetch()
			invitations

	App.reqres.setHandler "goal:judge:invitation:entities:all", (player) -> API.all(player)
	App.reqres.setHandler "goal:judge:invitation:entities:my:all", () -> API.all('my')
