@App.module "GoalConstructionApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class GoalConstructionRequest extends Backbone.Model
		default:
			goal: null
			startDate: null
			configuration: null
		idAttribute:
			'goalKey'
		url:
			App.Utils.toUrl("/construction/construction")
		validate: (attributes, options) ->
			if (attributes.goal == undefined)
				"Goal must be specified" #TODO use generic error code base with multi language support

	API=
		new: (configurations) ->
			constructionRequest = new GoalConstructionRequest()
			tomorrow = moment().add('days', 1).toDate().toJSON().slice(0,10)
			constructionRequest.set('startDate', tomorrow)

			constructionRequest.set("configuration", configurations.getSelected())
			constructionRequest.listenTo configurations, "selected", (model) ->
				constructionRequest.set('configuration', model.attributes)

			constructionRequest
		newByChoice: (choice) ->
			constructionRequest = new GoalConstructionRequest()
			tomorrow = moment().add('days', 1).toDate().toJSON().slice(0,10)
			constructionRequest.set('startDate', tomorrow)

			constructionRequest.set("configuration", choice.configuration.attributes)
			constructionRequest.listenTo choice.configuration, "change", (model) ->
				constructionRequest.set('configuration', model.attributes)

			constructionRequest

	App.reqres.setHandler "goal:construction:entities:new", (configurations) -> API.new(configurations)
	App.reqres.setHandler "goal:construction:entities:new:choice", (choice) -> API.newByChoice(choice)