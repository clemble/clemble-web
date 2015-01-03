@App.module "GoalSuggestionApp.List", (List, App, Backbone, Marionette, $, _) ->

	class Suggestion extends Marionette.ItemView
		template: require './templates/goal_suggestion'

	class Suggestions extends Marionette.CompositeView
		template: require './templates/goal_suggestions'
		childView : Suggestion
		childViewContainer : "#caption"

	Controller =
		listMy: (region) ->
			suggestions = App.request "goal:suggestion:entities:list:my"
			suggestionsView = new Suggestions
				collection: suggestions
			region.show suggestionsView

	App.reqres.setHandler "goal:suggestion:list:my", (region) -> Controller.listMy(region)