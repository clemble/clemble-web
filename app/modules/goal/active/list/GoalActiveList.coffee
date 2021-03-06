@App.module "GoalActiveApp.List", (List, App, Backbone, Marionette, $, _) ->

	Controller =
		listMy: (region) ->
			active = App.request "goal:active:entities:my"
			activeView = new GoalActives
				collection: active
			region.show activeView

	class GoalActive extends Marionette.ItemView
		template: (m) ->
			if (window.mobile)
				require('./templates/goal_active_sm')(m)
			else
				require('./templates/goal_active')(m)
		className: 'row list-group-item-success'
		events:
			"click #update" : () -> App.request "goal:active:action:new:modal", @model.url()
			"click #surrender": () -> App.request "goal:active:action:surrender", @model.url()
			"click #reached": () -> App.request "goal:active:action:reached", @model.url()
		modelEvents:
			"change" : "render"
			"sync" : "render"
		behaviors:
			Countdown: {}

	class GoalActives extends Marionette.CollectionView
#		template : require './templates/goal_actives'
		className : "list-group"
		modelEvents:
			"sync"    : "render"
		childView: GoalActive
		childViewContainer: "#content"

	App.reqres.setHandler "goal:active:list:my", (region) -> Controller.listMy(region)