@App.module "GoalApp.Timeline", (Timeline, App, Backbone, Marionette, $, _) ->

	Controller =
		myTimeline: (region) ->
			layout = new TimelineLayout
			layout.on "show", () ->
				App.request "goal:pending:list:my", layout.goalsRegion
				App.request "goal:duty:list:my", layout.goalsRegion
			region.show layout

	class TimelineLayout extends  Marionette.LayoutView
		template: require './templates/layout'
		regions:
			goalsRegion       : '#goalsRegion'
			dutiesRegion      : '#dutiesRegion'

	App.reqres.setHandler "goal:timeline:my", (region) -> Controller.myTimeline(region)

