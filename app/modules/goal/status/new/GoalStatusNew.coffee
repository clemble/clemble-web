@App.module "GoalStatusApp.New", (Entities, App, Backbone, Marionette, $, _) ->

	Controller =
		new: (goal, region) ->
			newGoalStatus = App.request("goal:status:entities:new", goal)
			newGoalStatusView = new Goal
				model: newGoalStatus
			region.show newGoalStatusView

	class Goal extends Marionette.ItemView
		template: require './templates/new'
		behaviors:
			StickIt: {}
		bindings: {
			'#status'  : 'status'
		}
		events:
			'click #save' : () -> @model.save()

	App.reqres.setHandler "goal:status:new", (goal, region) -> Controller.new(goal, region)
