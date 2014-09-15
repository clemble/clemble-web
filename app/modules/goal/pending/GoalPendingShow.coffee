@App.module "GoalTrack.Pending", (Pending, App, Backbone, Marionette, $, _) ->

	Controller =
		pending: (region) ->
			pendingGoals = App.request("goal:entities:my:pending")
			pendingGoals.on("sync", (collections) ->
				if (collections.length == 0)
					App.request "goal:new:my", region
				else
					pendingGoals.forEach( (goal) ->
						goalLayout = new GoalLayout
						goalLayout.on "show", () ->
							goalView = new Goal
								model: goal
							goalLayout.detailsRegion.show goalView
							App.request("goal:status:show", goal, goalLayout.statusRegion)
						region.show goalLayout
					)
			)
		myPending: (region) ->
			myGoals = App.request("goal:entities:my:pending")
			myGoalsView = new Goals
				collection: myGoals
			region.show myGoalsView


	class Goal extends Marionette.ItemView
		template: require './templates/goal'
		onShow: () ->
			now = new Date().getTime()
			timeSpent = (now - @model.get("startDate")) / 1000
			timeLeft = (@model.get("dueDate") - now) / 1000
			if (timeLeft > 0)
				$('#timeLeft').FlipClock(timeLeft, {
					clockFace: 'DailyCounter',
					countdown: true,
					showSeconds: true
				});
			$('#timeSpent').FlipClock(timeSpent, {
				clockFace: 'DailyCounter',
				showSeconds: true
			});

	class GoalLayout extends  Marionette.LayoutView
		template: require './templates/layout'
		regions:
			detailsRegion     : '#detailsRegion'
			statusRegion      : '#statusRegion'


	class Goals extends Marionette.CompositeView
		template: require './templates/goals'
		childView: Goal
		childViewContainer: 'div'

	App.reqres.setHandler "goal:pending:my", (region) -> Controller.pending(region)
	App.reqres.setHandler "goal:pending:list:my", (region) -> Controller.myPending(region)

