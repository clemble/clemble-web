@App.module "GoalActiveActionApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class GoalStatusUpdateAction extends Backbone.Model
		defaults:
			status    : null
			type      : "goal:management:status:update:action"

	class GoalReachedAction extends Backbone.Model
		defaults:
			status    : null
			type      : "goal:management:reached"

	API=
		newAction: (url) ->
			newAction = new GoalStatusUpdateAction()
			newAction.url = "#{url}/action"
			newAction
		newReached: (url) ->
			newReached = new GoalReachedAction()
			newReached.url = "#{url}/action"
			newReached

	App.reqres.setHandler "goal:active:action:entities:new", (url) -> API.newAction(url)