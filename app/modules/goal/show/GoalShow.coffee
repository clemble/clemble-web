@App.module "GoalApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		showMy: (region) ->
			layout = new GoalLayout()
			layout.on "show", () ->
				App.request "player:profile:show:my", layout.profileApp
				App.request "player:account:show:my", layout.accountApp
				App.request "goal:active:list:my", layout.mainApp
				App.request "goal:suggestion:list:my", layout.suggestionApp
				App.request "player:connection:show:my", layout.connectionApp
				App.request "notification:list:my", layout.notificationApp
				App.request "feed:list:my", layout.feedApp
				App.request "player:social:list:my", layout.socialConnectApp
				App.request "help:show", layout.helpApp
			region.show layout


	class GoalLayout extends Marionette.LayoutView
		template: require './templates/goal_layout'
		regions:
			mainApp         : "#mainApp"
			profileApp      : "#profileApp"
			accountApp      : "#accountApp"
			feedApp         : "#feedApp"
			helpApp         : "#helpApp"
			notificationApp : '#notificationApp'
			socialConnectApp: '#socialConnectApp'
			suggestionApp   : '#suggestionApp'
			connectionApp   : "#connectionApp"

	App.reqres.setHandler "goal:show:my", (region) -> Controller.showMy(region)