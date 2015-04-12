@App.module "GoalSuggestionApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class GoalSuggestionRequest extends Backbone.Model
		default:
			goal          : null
			timezone      : null
		idAttributes:
			'goalKey'
		initialize: () ->
			@set("timezone", moment().format('Z'))
		validate: (attributes, options) ->
			if (attributes.goal == undefined)
				"Goal must be specified" #TODO use generic error code base with multi language support

	class GoalSuggestionResponse extends Backbone.Model
		default:
			configuration : null
			accepted      : false

	class GoalSuggestion extends Backbone.Model
		idAttribute     : 'goalKey'

	class GoalSuggestions extends Backbone.Collection
		model : GoalSuggestion
		url   : App.Utils.toUrl("suggestion", "player/my")
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
	SUGGESTIONS.fetch()

	App.once "registered", () -> SUGGESTIONS.fetch()

	API=
		newRequest: (url) ->
			suggestionRequest = new GoalSuggestionRequest()
			suggestionRequest.url = url
			suggestionRequest

		newResponse: (model) ->
			suggestionResponse = new GoalSuggestionResponse()
			suggestionResponse.url = App.Utils.toUrl("suggestion", "player/my/#{model.get('goalKey')}")
			suggestionResponse

		listMy : () ->
			SUGGESTIONS

		listSuggested: (player) ->
			playerSuggested = new GoalSuggestions()
			playerSuggested.url = App.Utils.toUrl("suggestion", "suggested/#{player}")
			playerSuggested.fetch()
			playerSuggested

	App.reqres.setHandler "goal:suggestion:entities:new", (url, configurations) -> API.newRequest(url, configurations)
	App.reqres.setHandler "goal:suggestion:entities:response", (model) -> API.newResponse(model)

	App.reqres.setHandler "goal:suggestion:entities:list:my", () -> API.listMy()

	App.reqres.setHandler "goal:suggestion:entities:suggested", (player) -> API.listSuggested(player)
	App.reqres.setHandler "goal:suggestion:entities:suggested:my", () -> API.listSuggested('my')
