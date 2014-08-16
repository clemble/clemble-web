@App.module "GoalTrack.New", (New, App, Backbone, Marionette, $, _) ->

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
			@model.set("dueDate", moment().add('days', 7).toISOString())
			@model.save(@model.toJSON(), {
				success: () ->
					window.location.replace('./')
				error: () ->
					console.log("NO Error Processing for signUp failure")
			})


	App.reqres.setHandler "goal:new:my", (region) -> Controller.new(region)