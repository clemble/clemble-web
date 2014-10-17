@App.module "GoalRecordApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class GoalRecord extends Backbone.Model
		default:
			goalKey         : null
			state           : null
			player          : null
			goal            : null
			judge           : null
			configuration   : null
			eventRecords    : null


	class GoalRecords extends Backbone.Collection
		model: GoalRecord

	API =
		listMy: () ->
			records = new GoalRecords()
			records.url = "/goal/management/record/my"
			records.fetch()
			records

	App.reqres.setHandler "goal:record:entities:my", () -> API.listMy()

