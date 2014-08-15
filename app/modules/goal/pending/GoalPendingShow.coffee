@App.module "GoalTrack.Pending", (Pending, App, Backbone, Marionette, $, _) ->

	Controller =
		pending: (region) ->
			pendingGoals = App.request("goal:entities:my:pending")
			pendingGoals.on("sync", (collections) ->
				if (collections.length == 0)
					console.log("Collection #{JSON.stringify(collections)}")
					App.request "goal:new:my", region
				else
					pendingGoalsView = new Goals
						collection: pendingGoals
					region.show pendingGoalsView
			)

	class Goal extends Marionette.ItemView
		template: require './templates/goal'
		onShow: () ->
			$('#dueDate').FlipClock((@model.get("dueDate") - new Date().getTime()) / 1000, {
				clockFace: 'DailyCounter',
				countdown: true,
				showSeconds: false
			});

	class Goals extends Marionette.CompositeView
		template: require './templates/goals'
		childView: Goal
		childViewContainer: 'div'

	App.reqres.setHandler "goal:pending:my", (region) -> Controller.pending(region)

