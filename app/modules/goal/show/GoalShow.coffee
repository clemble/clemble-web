@App.module "GoalTrack.Pending", (Pending, App, Backbone, Marionette, $, _) ->

	Controller =
		pending: (region) ->
			pendingGoals = App.request("goal:entities:my:pending")
			pendingGoalsView = new Goals
				collection: pendingGoals
			region.show pendingGoalsView

	class Goal extends Marionette.ItemView
		template: require './templates/goal'

	class Goals extends Marionette.CompositeView
		template: require './templates/goals'
		childView: Goal
		childViewContainer: 'div'

	App.reqres.setHandler "goal:show:my:pending", (region) -> Controller.pending(region)

