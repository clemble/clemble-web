@App.module "GoalActiveApp.List", (List, App, Backbone, Marionette, $, _) ->

	Controller =
		listMy: (region) ->
			active = App.request "goal:active:entities:my"
			activeView = new GoalActives
				collection: active
			region.show activeView

	class GoalActive extends Marionette.ItemView
		template: require './templates/goal_active'
		className: 'row'
		events:
			"click #update" : "update"
		update: () -> App.request "goal:active:action:new:modal", @model.url()
		modelEvents:
			"change" : "render"
		behaviors:
			Countdown: {}

	class GoalActives extends Marionette.CompositeView
		template : require './templates/goal_actives'
		modelEvents:
			"sync"    : "render"
		childView: GoalActive
		childViewContainer: "#content"

	App.reqres.setHandler "goal:active:list:my", (region) -> Controller.listMy(region)