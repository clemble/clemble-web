require './show/HelpShow'

@App.module "HelpApp", (HelpApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		showHelp: ->
			App.request "help:show", App.contentRegion

	class GoalNotificationRouter extends Marionette.AppRouter
		appRoutes:
			'help': 'showHelp'

	App.addInitializer ->
		new GoalNotificationRouter
			controller: API