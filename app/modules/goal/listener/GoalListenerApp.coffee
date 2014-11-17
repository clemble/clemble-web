@App.module "GoalApp.GoalListenerApp", (GoalListenerApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	player = $.cookie("player")

	App.on "goal:management", (event) ->
		if ((event.player? && event.player == player) || (event.state.player? && event.state.player == player))
			App.trigger "goal:management:my", event
		else
			App.trigger "goal:management:friend", event