@App.module "GoalApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		showMy: (region) ->
			layout = new GoalLayout()
			layout.on "show", () ->
				App.request "player:profile:show:my", layout.profileApp
				App.request "player:account:show:my", layout.accountApp
				App.request "goal:active:list:my", layout.mainRegion
				App.request "goal:initiation:list:my", layout.initiationApp
			region.show layout


	class GoalLayout extends Marionette.LayoutView
		template: require './templates/goal_layout'
		regions:
			mainRegion    : "#mainRegion"
			initiationApp : "#initiationApp"
			profileApp    : "#profileApp"
			accountApp    : "#accountApp"

	App.reqres.setHandler "goal:show:my", (region) -> Controller.showMy(region)