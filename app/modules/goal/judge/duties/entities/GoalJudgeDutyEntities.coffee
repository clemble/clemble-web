@App.module "GoalJudgeDutyApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class GoalJudgeDuty extends Backbone.Model
		defaults:
			goalKey : null
			player  : null
			judge   : null
			status  : null
		idAttribute:
			'goalKey'

	class GoalJudgeDuties extends Backbone.Collection
		model: GoalJudgeDuty

	API =
		pending: (player) ->
			pending = new GoalJudgeDuties()
			pending.url = "/goal/duty/#{player}"
			pending.fetch()
			pending

	App.reqres.setHandler "goal:judge:duty:entities:pending", (player) -> API.pending(player)
