@App.module "GoalJudgeInvitationApp.List", (List, App, Backbone, Marionette, $, _) ->

	Controller =
		list: (player, region) ->
			invitations = App.request "goal:judge:invitation:entities:all", player
			invitationsView = new GoalJudgeInvitations
				collection: invitations
			region.show invitationsView
			invitations
		listDuties: (player, region) ->
			invitations = App.request "goal:judge:invitation:entities:all:duties", player
			invitationsView = new GoalJudgeInvitations
				collection: invitations
			region.show invitationsView
			invitations


	class GoalJudgeInvitation extends Marionette.ItemView
		template: require './templates/invitation'

	class GoalJudgeInvitations extends Marionette.CompositeView
		template: require './templates/invitations'
		childView: GoalJudgeInvitation
		childViewContainer: 'div'

	App.reqres.setHandler "goal:judge:invitation:list", (player, region) -> Controller.list(player, region)
	App.reqres.setHandler "goal:judge:invitation:list:my", (region) -> Controller.list('my', region)
	App.reqres.setHandler "goal:judge:invitation:list:my:duties", (region) -> Controller.listDuties('my', region)
