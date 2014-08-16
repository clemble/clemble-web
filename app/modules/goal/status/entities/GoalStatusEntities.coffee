@App.module "GoalStatusApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class GoalStatus extends Backbone.Model
		defaults:
			status      : null
			statusDate  : null

	class GoalStatuses extends Backbone.Collection
		model:
			GoalStatus

	API =
		new: (goal) ->
			goalStatus = new GoalStatus(goal.get("status"))
			goalStatus.url = "/goal/track/my/#{goal.get("goalKey")['goal']}/status"
			goalStatus

	App.reqres.setHandler "goal:status:entities:all", (goal) -> API.all(goal)
	App.reqres.setHandler "goal:status:entities:new", (goal) -> API.new(goal)