@App.module "GoalTrack.Pending", (Pending, App, Backbone, Marionette, $, _) ->

	Controller =
		new: (region) ->
			newGoal = App.request("goal:entities:my:new")
			newGoalView = new Goal
				model: newGoal
			region.show newGoalView

	class Goal extends Marionette.ItemView
		template: require './templates/new_goal'
		behaviors:
			StickIt: {}
		bindings: {
			'#description'  : 'description'
			'#dueDate'      : {
				observe: 'dueDate'
				onSet: (value) -> Number(value)
			}
		}
		events:
			'click #save' : 'save'
		save: () ->
			@model.save()


	App.reqres.setHandler "goal:new:my", (region) -> Controller.new(region)