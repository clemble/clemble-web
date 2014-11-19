@App.module "GoalApp.Timeline", (Timeline, App, Backbone, Marionette, $, _) ->

	Controller =
		myTimeline: (region) ->
			timeline = App.request("goal:timeline:entities:my")
			timelineView = new Timeline
				collection: timeline
			region.show timelineView

	class Goal extends Marionette.ItemView
		template: require './templates/goal_timeline'
		modelEvents:
			"change" : "render"
		events:
			"click #bet": "bet"
		bet: () ->
			console.log("Bet")

	class Timeline extends Marionette.CompositeView
		template : require './templates/goal_timelines'
		modelEvents:
			"sync" : "render"
		childView: Goal
		childViewContainer: "#content"


	App.reqres.setHandler "goal:timeline:list:my", (region) -> Controller.myTimeline(region)

