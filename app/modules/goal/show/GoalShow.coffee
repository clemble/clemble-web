@App.module "GoalApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		showMy: (region) ->
			layout = new GoalLayout()
			layout.on "show", () ->
				App.request "player:profile:show:my", layout.profileApp
				App.request "player:account:show:my", layout.accountApp
				App.request "goal:active:list:my", layout.mainApp
				App.request "goal:initiation:list:my", layout.initiationApp
				App.request "player:connection:show:my", layout.connectionApp
				App.request "notification:list:my", layout.notificationApp
				App.request "feed:list:my", layout.feedApp
				App.request "goal:initiation:list:my:friend", layout.challengesApp
			region.show layout


	class GoalLayout extends Marionette.LayoutView
		template: require './templates/goal_layout'
		regions:
			mainApp         : "#mainApp"
			challengesApp   : "#challengesApp"
			initiationApp   : "#initiationApp"
			profileApp      : "#profileApp"
			accountApp      : "#accountApp"
			feedApp         : "#feedApp"
			notificationApp : '#notificationApp'
			connectionApp   : "#connectionApp"

	App.reqres.setHandler "goal:show:my", (region) -> Controller.showMy(region)