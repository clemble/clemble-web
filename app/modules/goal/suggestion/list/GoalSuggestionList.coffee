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
			$.ajax({
				type: 'POST',
				url: "/suggestion/player/my/#{@model.get('goalKey')}",
				data: JSON.stringify(accept),
				contentType: "application/json",
				dataType: 'json'
			})


	class Suggestions extends Marionette.CompositeView
		template: require './templates/goal_suggestions'
		childView : Suggestion
		childViewContainer : "#caption"
		modelEvents:
			"sync"  : "render"
			"change": "render"

	Controller =
		listMy: (region) ->
			suggestions = App.request "goal:suggestion:entities:list:my"
			suggestionsView = new Suggestions
				collection: suggestions
			region.show suggestionsView

	App.reqres.setHandler "goal:suggestion:list:my", (region) -> Controller.listMy(region)