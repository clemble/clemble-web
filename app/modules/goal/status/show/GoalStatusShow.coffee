@App.module "GoalStatusApp.New", (Entities, App, Backbone, Marionette, $, _) ->

	Controller =
		show: (goal, region) ->
			newGoalStatus = App.request("goal:status:entities:new", goal)
			newGoalStatusView = new GoalStatus
				model: newGoalStatus
			region.show newGoalStatusView

	class GoalStatus extends Marionette.ItemView
		template: require './templates/show'
		behaviors:
			StickIt: {}
		bindings: {
			'#status'  : 'status'
		}
		events:
			'change #status' : () -> @model.save()

	App.reqres.setHandler "goal:status:show", (goal, region) -> Controller.show(goal, region)
