require './entities/VictoryEntities'
require './list/VictoryList'

@App.module "VictoryApp", (VictoryApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		listVictories: ->
			App.request "victory:list:my", App.contentRegion

	class GoalVictoryRouter extends Marionette.AppRouter
		appRoutes:
			'victory': 'listVictories'

	App.addInitializer ->
		new GoalVictoryRouter
			controller: API