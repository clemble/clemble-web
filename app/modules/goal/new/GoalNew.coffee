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
			'#goal'       : 'goal'
			'#judge'      : 'judge'
			'#dueDate'    : {
				observe: 'dueDate'
				onSet: (value) -> Number(value)
			}
		}
		events:
			'click #save' : 'save'
		save: () ->
			console.log("Saving #{JSON.stringify(@model.toJSON())}")
			@model.save(@model.toJSON(), {
				success: () ->
					window.location.replace('./')
				error: () ->
					console.log("NO Error Processing for signUp failure #{@model.toJSON()}")
			})


	App.reqres.setHandler "goal:new:my", (region) -> Controller.new(region)