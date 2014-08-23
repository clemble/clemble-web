@App.module "GoalJudgeInvitationApp.Pending", (Pending, App, Backbone, Marionette, $, _) ->

	Controller =
		pending: (player, region) ->
			invitations = App.request "goal:judge:invitation:entities:pending", player
			invitationsView = new PendingGoalJudgeInvitations
				collection: invitations
			region.show invitationsView
			invitations

	class PendingGoalJudgeInvitation extends Marionette.ItemView
		template: require './templates/pending_invitation'
		events:
			'click #accept': () -> @model.set('status', 'accept')
			'click #decline': () -> @model.set('status', 'decline')

	class PendingGoalJudgeInvitations extends Marionette.CompositeView
		template: require './templates/pending_invitations'
		childView: PendingGoalJudgeInvitation
		childViewContainer: 'div'

	App.reqres.setHandler "goal:judge:invitation:pending", (player, region) -> Controller.pending(player, region)
	App.reqres.setHandler "goal:judge:invitation:pending:my", (region) -> Controller.pending('my', region)

