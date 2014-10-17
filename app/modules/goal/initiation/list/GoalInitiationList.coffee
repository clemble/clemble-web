@App.module "GoalInitiationApp.List", (List, App, Backbone, Marionette, $, _) ->

	Controller =
		listMy: (region) ->
			initiations = App.request "goal:initiation:entities:my"
			initiationsView = new GoalInitiations
				collection: initiations
			region.show initiationsView


	class GoalInitiation extends Marionette.ItemView
		template: require './templates/goal_initiation'
		behaviors:
			FlowClock: {}

	class GoalInitiations extends Marionette.CompositeView
		template: require './templates/goal_initiations'
		childView: GoalInitiation
		childViewContainer: "#content"
		emptyView: GoalInitiationsEmpty
		modelEvents:
			"sync" : "render"

	class GoalInitiationsEmpty extends Marionette.ItemView
		template: require './templates/goal_initiation_empty'

	App.reqres.setHandler "goal:initiation:list:my", (region) -> Controller.listMy(region)