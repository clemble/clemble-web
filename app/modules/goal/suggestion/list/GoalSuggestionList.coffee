@App.module "GoalSuggestionApp.List", (List, App, Backbone, Marionette, $, _) ->

	class Suggested extends Marionette.ItemView
		template: require './templates/suggested'
		className: 'row'

	class Suggesteds extends Marionette.CompositeView
		template: require './templates/suggested_all'
		childView : Suggested
		childViewContainer : "#caption"
		emptyView: SuggestionEmpty

	class Suggestion extends Marionette.ItemView
		template: require './templates/suggestion'
		className: 'row'
		events:
			'click #accept'  : 'accept'
			'click #decline' : 'decline'
		accept: () ->
			@process(true)
		decline: () ->
			@process(false)
		process: (accept) ->
			url = App.Utils.toUrl("/suggestion/player/my/#{@model.get('goalKey')}")
			$.ajax({
				type: 'POST',
				url: url,
				data: JSON.stringify(accept),
				contentType: "application/json",
				dataType: 'json'
			})

	class Suggestions extends Marionette.CompositeView
		template: require './templates/suggestions'
		childView : Suggestion
		childViewContainer : "#caption"
		emptyView: SuggestionEmpty
		modelEvents:
			"sync"  : "render"
			"change": "render"

	class SuggestionEmpty extends Marionette.ItemView
		template: require './templates/suggestions_empty'

	class SuggestionLayout extends Marionette.LayoutView
		template: require './templates/suggestion_layout'
		regions:
			suggestionApp     : "#suggestionApp"
			suggestedApp      : "#suggestedApp"

	Controller =
		listMy: (region) ->
			suggestionLayout = new SuggestionLayout
			suggestionLayout.on "show", () ->

				suggestions = App.request "goal:suggestion:entities:list:my"
				suggestionsView = new Suggestions
					collection: suggestions
				suggestionLayout.suggestionApp.show suggestionsView

				suggested = App.request "goal:suggestion:entities:suggested:my"
				suggestedView = new Suggesteds
					collection: suggested
				suggestionLayout.suggestedApp.show suggestedView
			region.show suggestionLayout

	App.reqres.setHandler "goal:suggestion:list:my", (region) -> Controller.listMy(region)