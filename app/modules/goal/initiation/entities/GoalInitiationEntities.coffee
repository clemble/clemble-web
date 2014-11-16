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
			initiations.url = App.Utils.toUrl("/construction/initiation/my")
			App.on "goal:initiation:created", () -> initiations.fetch()
			initiations.fetch()
			initiations

	App.reqres.setHandler "goal:initiation:entities:my", () -> API.listMy()