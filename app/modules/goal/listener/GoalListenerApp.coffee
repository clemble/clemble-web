@App.module "GoalApp.GoalListenerApp", (GoalListenerApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	player = $.cookie("player")

	App.on "goal:management", (event) ->
		# Triggering event for goal
		App.trigger "goal:management:#{event.goalKey}", event
		# Triggering event for my events
		if ((event.player? && event.player == player) || (event.state? && event.state.player? && event.state.player == player))
			App.trigger "goal:management:my", event
		else
			App.trigger "goal:management:friend", event