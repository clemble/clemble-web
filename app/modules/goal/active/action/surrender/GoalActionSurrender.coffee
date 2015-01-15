@App.module "GoalActionSurrender.New", (GoalActionSurrender, App, Backbone, Marionette, $, _) ->

	Controller =
		surrender: (url) ->
			surrenderAction = App.request "goal:active:action:entities:surrender", url
			surrenderAction.save()

	App.reqres.setHandler "goal:active:action:surrender", (url) -> Controller.surrender(url)

