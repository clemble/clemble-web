@App.module "GoalConstructionApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class GoalConstructionRequest extends Backbone.Model
		default:
			goal: null
			configuration: null

	API=
		new: (configurations) ->
			constructionRequest = new GoalConstructionRequest()
			constructionRequest.set("configuration", configurations.getSelected())
			constructionRequest.listenTo configurations, "selected", (model) ->
				constructionRequest.set('configuration', model.attributes)
			constructionRequest.url = "/goal/construction/"
			constructionRequest.on("all", (event) -> console.log("construction request #{event}"))
			constructionRequest

	App.reqres.setHandler "goal:construction:entities:new", (configurations) -> API.new(configurations)