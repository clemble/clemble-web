@App.module "GoalSuggestionApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class GoalSuggestionRequest extends Backbone.Model
		default:
			goal          : null
			configuration : null
		validate: (attributes, options) ->
			if (attributes.goal == undefined)
				"Goal must be specified" #TODO use generic error code base with multi language support

	API=
		new: (url, configurations) ->
			suggestionRequest = new GoalSuggestionRequest()
			suggestionRequest.set("configuration", configurations.getSelected())
			suggestionRequest.listenTo configurations, "selected", (model) ->
				suggestionRequest.set('configuration', model.attributes)
			suggestionRequest.url = url
			suggestionRequest.on("all", (event) -> console.log("Suggestion request #{event}"))
			suggestionRequest

	App.reqres.setHandler "goal:suggestion:entities:new", (url, configurations) -> API.new(url, configurations)