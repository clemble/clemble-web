@App.module "GoalActiveActionApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class GoalStatusUpdateAction extends Backbone.Model
		defaults:
			status    : null
			progress  : null
			type      : "goal:management:status:update:action"

	API=
		newAction: (url) ->
			newAction = new GoalStatusUpdateAction()
			newAction.url = "#{url}/action"
			newAction

	App.reqres.setHandler "goal:active:action:entities:new", (url) -> API.newAction(url)