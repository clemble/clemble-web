@App.module "GoalJudgeInvitationApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class GoalJudgeInvitation extends Backbone.Model
		defaults:
			goalKey : null
			player  : null
			judge   : null
			goal    : null
			status  : null
		idAttribute:
			'goalKey'

	class GoalJudgeInvitations extends Backbone.Collection
		model: GoalJudgeInvitation

	API =
		pending: (player) ->
			pending = new GoalJudgeInvitations()
			pending.url = "/goal/judge/invitations/#{player}/pending"
			pending.fetch()
			pending
		accepted: (player) ->
			accepted = new GoalJudgeInvitations()
			accepted.url = "/goal/judge/invitations/#{player}/accepted"
			accepted.fetch()
			accepted
		declined: (player) ->
			declined = new GoalJudgeInvitations()
			declined.url = "/goal/judge/invitations/#{player}/declined"
			declined.fetch()
			declined

	App.reqres.setHandler "goal:judge:invitation:entities:pending", (player) -> API.pending(player)
	App.reqres.setHandler "goal:judge:invitation:entities:accepted", (player) -> API.accepted(player)
	App.reqres.setHandler "goal:judge:invitation:entities:declined", (player) -> API.declined(player)
