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
							App.request("goal:bid:show", goal, goalLayout.bidRegion)
							App.request("player:profile:show:my", goalLayout.profileRegion)
						region.show goalLayout
					)
			)

	class Goal extends Marionette.ItemView
		template: require './templates/goal'
		onShow: () ->
			timeSpent = (new Date().getTime() - @model.get("startDate")) / 1000
			timeLeft = (@model.get("dueDate") - new Date().getTime()) / 1000
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
			detailsRegion   : '#detailsRegion'
			statusRegion    : '#statusRegion'
			bidRegion       : '#bidRegion'
			profileRegion   : '#profileRegion'


	class Goals extends Marionette.CompositeView
		template: require './templates/goals'
		childView: Goal
		childViewContainer: 'div'

	App.reqres.setHandler "goal:pending:my", (region) -> Controller.pending(region)

