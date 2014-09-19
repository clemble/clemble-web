@App.module "GoalInitiationApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class GoalInitiation extends Backbone.Model
		default:
			goalKey       : null
			player        : null
			startDate     : null
			configuration : null

	class GoalInitiations extends Backbone.Collection
		model: GoalInitiation
		comparator: 'startDate'

	API =
		listMy: () ->
			initiations = new GoalInitiations()
			initiations.url = "/goal/construction/initiation/my"
			initiations.fetch()
			initiations

	App.reqres.setHandler "goal:initiation:entities:my", () -> API.listMy()