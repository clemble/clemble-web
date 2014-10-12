@App.module "GoalActiveApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class GoalState extends Backbone.Model
		default:
			goalKey       : null
			player        : null
			configuration : null
			status        : null
			parts         : 0
			progress      : 0
			context       : null

	class GoalStates extends Backbone.Collection
		model: GoalState

	API=
		myActive: () ->
			active = new GoalStates()
			active.url = '/goal/management/active/my'
			active.fetch()
			active

	App.reqres.setHandler "goal:active:entities:my", () -> API.myActive()