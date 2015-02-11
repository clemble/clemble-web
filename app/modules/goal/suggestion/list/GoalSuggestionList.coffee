@App.module "GoalSuggestionApp.List", (List, App, Backbone, Marionette, $, _) ->

	class Suggestion extends Marionette.ItemView
		template: require './templates/goal_suggestion'
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
		template: require './templates/goal_suggestions'
		childView : Suggestion
		childViewContainer : "#caption"
		emptyView: SuggestionEmpty
		modelEvents:
			"sync"  : "render"
			"change": "render"

	class SuggestionEmpty extends Marionette.ItemView
		template: require './templates/empty_suggestions'

	Controller =
		listMy: (region) ->
			suggestions = App.request "goal:suggestion:entities:list:my"
			suggestionsView = new Suggestions
				collection: suggestions
			region.show suggestionsView

	App.reqres.setHandler "goal:suggestion:list:my", (region) -> Controller.listMy(region)