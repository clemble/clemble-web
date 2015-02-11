require "./entities/GoalSuggestionEntities"
require './list/GoalSuggestionList'
require './new/GoalSuggestionNew'

@App.module "GoalSuggestionApp", (GoalSuggestionApp, App, Backbone, Marionette, $, _) ->

	API =
		showSuggestions: ->
			App.request "goal:suggestion:list:my", App.contentRegion

	class GoalSuggestionRouter extends Marionette.AppRouter
		appRoutes:
			'suggestion': 'showSuggestions'

	App.addInitializer ->
		new GoalSuggestionRouter
			controller: API