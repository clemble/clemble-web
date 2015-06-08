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
			App.Utils.toUrl("goal", "construction")
		validate: (attributes, options) ->
			if (attributes.goal == undefined)
				"Goal must be specified" #TODO use generic error code base with multi language support

	API=
		new: (configurations) ->
			constructionRequest = new GoalConstructionRequest()
			configurations.linkTo(constructionRequest)
			constructionRequest
		newByChoice: (choice) ->
			constructionRequest = new GoalConstructionRequest()
			choice.linkTo(constructionRequest)
			constructionRequest
		newByInterval: (interval) ->
			constructionRequest = new GoalConstructionRequest()
			interval.linkTo(constructionRequest)
			constructionRequest

	App.reqres.setHandler "goal:construction:entities:new", (configurations) -> API.new(configurations)
	App.reqres.setHandler "goal:construction:entities:new:choice", (choice) -> API.newByChoice(choice)
	App.reqres.setHandler "goal:construction:entities:new:interval", (interval) -> API.newByInterval(interval)