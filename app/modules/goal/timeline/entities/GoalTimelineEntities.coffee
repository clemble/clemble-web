@App.module "GoalTimelineApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class GoalTimeline extends Backbone.Model
		default:
			goalKey         : null
			player          : null
			goal            : null
			configuration   : null
			context         : null
			status          : null
			bids            : []
		idAttribute       : "goalKey"
		initialize: () ->
			for playerBid in @get("bank").bids
				if (playerBid.player == App.player)
					@set('my', playerBid.bid)

	class GoalTimelines extends Backbone.Collection
		model: GoalTimeline

	API =
		list: (player) ->
			timeline = new GoalTimelines()
			timeline.url = App.Utils.toUrl("/management/connections/timeline/#{player}")
			App.request("listener:subscribe", "goal:management", timeline, (body) -> new GoalTimeline(body))
			timeline.fetch()
			timeline

	App.reqres.setHandler "goal:timeline:entities", (player) -> API.list(player)
	App.reqres.setHandler "goal:timeline:entities:my", () -> API.list("my")

