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
		idAttribute: 'goalKey'


	class GoalRecords extends Backbone.Collection
		model: GoalRecord

	API =
		list: (player) ->
			records = new GoalRecords()
			records.url = App.Utils.toUrl("/management/record/#{player}")
			records.fetch()
			records
		listWithState: (player, state) ->
			records = new GoalRecords()
			records.url = App.Utils.toUrl("/management/record/#{player}/#{state}")
			App.request("listener:subscribe:my", "goal:record", records, (body) -> new GoalRecord(body))
			records.fetch()
			records

	App.reqres.setHandler "goal:record:entities", (player) -> API.list(player)
	App.reqres.setHandler "goal:record:entities:my", () -> API.list("my")
	App.reqres.setHandler "goal:record:entities:state", (player, state) -> API.listWithState(player, state)
	App.reqres.setHandler "goal:record:entities:my:state", (state) -> API.listWithState("my", state)

