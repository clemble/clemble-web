@App.module "GoalStatusApp.New", (Entities, App, Backbone, Marionette, $, _) ->

	Controller =
		list: (goal, region) ->
			goalStatuses = App.request("goal:status:entities:all", goal)
			goalStatusesView = new GoalStatuses
				collection: goalStatuses
			region.show goalStatusesView

	class GoalStatus extends Marionette.ItemView
		template: require './templates/status'

	class GoalStatuses extends Marionette.CompositeView
		template: require './templates/statuses'
		childView: GoalStatus
		childViewContainer: '#statuses'

	App.reqres.setHandler "goal:status:list", (goal, region) -> Controller.list(goal, region)
