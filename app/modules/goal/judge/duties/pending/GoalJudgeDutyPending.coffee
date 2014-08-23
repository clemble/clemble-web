@App.module "GoalJudgeInvitationApp.Pending", (Pending, App, Backbone, Marionette, $, _) ->

	Controller =
		pending: (player, region) ->
			duties = App.request "goal:judge:duty:entities:pending", player
			dutiesView = new PendingGoalJudgeDuties
				collection: duties
			region.show dutiesView
			duties

	class PendingGoalJudgeDuty extends Marionette.ItemView
		template: require './templates/pending_duty'

	class PendingGoalJudgeDuties extends Marionette.CompositeView
		template: require './templates/pending_duties'
		childView: PendingGoalJudgeDuty
		childViewContainer: 'div'

	App.reqres.setHandler "goal:judge:duty:pending", (player, region) -> Controller.pending(player, region)
	App.reqres.setHandler "goal:judge:duty:pending:my", (region) -> Controller.pending('my', region)

