@App.module "GoalConstructionApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class GoalConstructionRequest extends Backbone.Model
		default:
			goal: null
			timezone: null
			configuration: null
		idAttribute:
			'goalKey'
		initialize: () ->
			@set("timezone", moment().format('Z'))
		url:
			App.Utils.toUrl("/construction/construction")
		validate: (attributes, options) ->
			if (attributes.goal == undefined)
				"Goal must be specified" #TODO use generic error code base with multi language support

	API=
		new: (configurations) ->
			constructionRequest = new GoalConstructionRequest()

			constructionRequest.set("configuration", configurations.getSelected())
			constructionRequest.listenTo configurations, "selected", (model) ->
				constructionRequest.set('configuration', model.attributes)

			constructionRequest
		newByChoice: (choice) ->
			constructionRequest = new GoalConstructionRequest()

			constructionRequest.set("configuration", choice.configuration.attributes)
			constructionRequest.listenTo choice.configuration, "change", (model) ->
				constructionRequest.set('configuration', model.attributes)

			constructionRequest
		newByInterval: (interval) ->
			constructionRequest = new GoalConstructionRequest()

			constructionRequest.set("configuration", interval.get('configuration'))
			constructionRequest.listenTo interval, "change:configuration", (model) ->
				constructionRequest.set('configuration', model.get('configuration'))

			constructionRequest

	App.reqres.setHandler "goal:construction:entities:new", (configurations) -> API.new(configurations)
	App.reqres.setHandler "goal:construction:entities:new:choice", (choice) -> API.newByChoice(choice)
	App.reqres.setHandler "goal:construction:entities:new:interval", (interval) -> API.newByInterval(interval)