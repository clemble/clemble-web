@App.module "GoalApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		showMy: (region) ->
			layout = new GoalLayout()
			layout.on "show", () ->
				App.request "player:profile:show:my", layout.profileApp
				App.request "player:account:show:my", layout.accountApp
				App.request "goal:active:list:my", layout.mainApp
				App.request "goal:initiation:list:my", layout.initiationApp
				App.request "goal:record:list:my:state", "finished", layout.recordApp
				App.request "goal:timeline:list:my", layout.timelineApp
				App.request "player:connection:show:my", layout.connectionApp
				App.request "goal:initiation:list:my:friend", layout.challengesApp
			region.show layout


	class GoalLayout extends Marionette.LayoutView
		template: require './templates/goal_layout'
		regions:
			mainApp       : "#mainApp"
			challengesApp : "#challengesApp"
			initiationApp : "#initiationApp"
			profileApp    : "#profileApp"
			accountApp    : "#accountApp"
			recordApp     : "#recordApp"
			timelineApp   : "#timelineApp"
			connectionApp : "#connectionApp"

	App.reqres.setHandler "goal:show:my", (region) -> Controller.showMy(region)