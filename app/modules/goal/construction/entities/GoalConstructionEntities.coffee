@App.module "GoalConstructionApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class GoalConstructionRequest extends Backbone.Model
		default:
			goal: null
			configuration: null

	API=
		new: (configurations) ->
			constructionRequest = new GoalConstructionRequest()
			constructionRequest.listenTo configurations, "select", (model) ->
				constructionRequest.set('configuration', model.attributes)
			constructionRequest.on("all", (event) -> console.log("construction request #{event}"))
			constructionRequest

	App.reqres.setHandler "goal:construction:entities:new", (configurations) -> API.new(configurations)