@App.module "GoalTrack.Pending", (Pending, App, Backbone, Marionette, $, _) ->

	Controller =
		pending: (player, region) ->
			pendingGoals = App.request("goal:track:entities:pending", player)
			pendingGoalsView = new Goals
				collection: pendingGoals
			region.show pendingGoalsView

	class Goal extends Marionette.ItemView
		template: require './templates/goal'

	class Goals extends Marionette.CompositeView
		template: require './templates/goals'
		childView: Goal
		childViewContainer: 'div'

	App.reqres.setHandler "goal:track:pending", (player, region) -> Controller.pending(player, region)

