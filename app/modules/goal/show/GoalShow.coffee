@App.module "GoalApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		showMy: (region) ->
			layout = new GoalLayout()
			layout.on "show", () ->
				App.request "goal:construction:my:new", layout.newGoalApp
				App.request "goal:active:list:my", layout.mainApp
				App.request "player:connection:show:my", layout.connectionApp
				App.request "feed:list:my", layout.feedApp
			region.show layout


	class GoalLayout extends Marionette.LayoutView
		template: require './templates/goal_layout'
		regions:
			newGoalApp      : "#newGoalApp"
			mainApp         : "#mainApp"
			profileApp      : "#profileApp"
			accountApp      : "#accountApp"
			feedApp         : "#feedApp"
			connectionApp   : "#connectionApp"

	App.reqres.setHandler "goal:show:my", (region) -> Controller.showMy(region)