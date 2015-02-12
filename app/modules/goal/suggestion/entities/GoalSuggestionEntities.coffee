@App.module "GoalSuggestionApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class GoalSuggestionRequest extends Backbone.Model
		default:
			goal          : null
			configuration : null
		idAttributes:
			'goalKey'
		validate: (attributes, options) ->
			if (attributes.goal == undefined)
				"Goal must be specified" #TODO use generic error code base with multi language support

	class GoalSuggestion extends Backbone.Model
		idAttribute     : 'goalKey'

	class GoalSuggestions extends Backbone.Collection
		model : GoalSuggestion
		url   : App.Utils.toUrl("/suggestion/player/my")
		fetchIfNeeded: () ->
			if (!@fetched)
				@fetched = true
				@fetch()

	SUGGESTIONS = new GoalSuggestions()
	App.on "goal:suggestion:created:my", (suggestion) ->
		SUGGESTIONS.add(new GoalSuggestion(suggestion.body))
	App.on "goal:suggestion:declined:my", (suggestion) ->
		SUGGESTIONS.remove(new GoalSuggestion(suggestion.body))
	App.on "goal:suggestion:accepted:my", (suggestion) ->
		SUGGESTIONS.remove(new GoalSuggestion(suggestion.body))

	API=
		new: (url, configurations) ->
			suggestionRequest = new GoalSuggestionRequest()
			suggestionRequest.set("configuration", configurations.getSelected())
			suggestionRequest.listenTo configurations, "selected", (model) ->
				suggestionRequest.set('configuration', model.attributes)
			suggestionRequest.url = url
			suggestionRequest.on("all", (event) -> console.log("Suggestion request #{event}"))
			suggestionRequest
		newByChoice: (url, choice) ->
			suggestionRequest = new GoalSuggestionRequest()
			suggestionRequest.url = url

			suggestionRequest.set("configuration", choice.configuration.attributes)
			suggestionRequest.listenTo choice.configuration, "change", (model) ->
				suggestionRequest.set('configuration', model.attributes)

			suggestionRequest
		newByInterval: (url, interval) ->
			suggestionRequest = new GoalSuggestionRequest()
			suggestionRequest.url = url

			suggestionRequest.set("configuration", interval.get('configuration'))
			suggestionRequest.listenTo interval, "change:configuration", (model) ->
				suggestionRequest.set('configuration', model.get('configuration'))


			suggestionRequest

		listMy : () ->
			SUGGESTIONS.fetchIfNeeded()
			SUGGESTIONS

		listSuggested: (player) ->
			playerSuggested = new GoalSuggestions()
			playerSuggested.url = App.Utils.toUrl("/suggestion/suggested/#{player}")
			playerSuggested.fetch()
			playerSuggested

	App.reqres.setHandler "goal:suggestion:entities:new", (url, configurations) -> API.new(url, configurations)
	App.reqres.setHandler "goal:suggestion:entities:new:choice", (url, choice) -> API.newByChoice(url, choice)
	App.reqres.setHandler "goal:suggestion:entities:new:interval", (url, interval) -> API.newByInterval(url, interval)
	App.reqres.setHandler "goal:suggestion:entities:list:my", () -> API.listMy()

	App.reqres.setHandler "goal:suggestion:entities:suggested", (player) -> API.listSuggested(player)
	App.reqres.setHandler "goal:suggestion:entities:suggested:my", () -> API.listSuggested('my')
