@App.module "GoalActiveApp.List", (List, App, Backbone, Marionette, $, _) ->

	Controller =
		listMy: (region) ->
			active = App.request "goal:active:entities:my"
			activeView = new GoalActives
				collection: active
			region.show activeView


	class GoalActive extends Marionette.ItemView
		template: require './templates/goal_active'

	class GoalActives extends Marionette.CompositeView
		template : require './templates/goal_actives'
		modelEvents:
			"sync" : "render"
		childView: GoalActive
		childViewContainer: "#content"
		emptyView: GoalActiveEmpty

	class GoalActiveEmpty extends Marionette.ItemView
		template: require "./templates/goal_active_empty"

	App.reqres.setHandler "goal:active:list:my", (region) -> Controller.listMy(region)