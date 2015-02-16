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
			"click #update" : () -> App.request "goal:active:action:new:modal", @model.url()
			"click #surrender": () -> App.request "goal:active:action:surrender", @model.url()
			"click #reached": () -> App.request "goal:active:action:reached", @model.url()
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
		events:
			"click #add": () -> App.request "goal:construction:my:new:modal"

	App.reqres.setHandler "goal:active:list:my", (region) -> Controller.listMy(region)