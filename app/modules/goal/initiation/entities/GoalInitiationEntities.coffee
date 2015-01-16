@App.module "GoalInitiationApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	player = App.player

	class GoalInitiation extends Backbone.Model
		default:
			goalKey       : null
			player        : null
			startDate     : null
			configuration : null
		idAttribute     : 'goalKey'
		urlRoot         : App.Utils.toUrl("/construction/initiation/")
		initialize      : () ->
			self = @
			@on "change:bank", @checkMy
			@on "change:player", @checkMy
			@checkMy()
		checkMy  : () =>
			if(@get("player") == player)
				@set('my', @get("configuration").bid)
			for playerBid in @get("bank").bids
				if (playerBid.player == player)
					@set('my', playerBid.bid)

	class GoalInitiations extends Backbone.Collection
		model: GoalInitiation
		comparator: 'startDate'

	API =
		listMy: () ->
			initiations = new GoalInitiations()
			initiations.url = App.Utils.toUrl("/construction/player/initiation/my")
			App.request("listener:subscribe:my", "goal:initiation", initiations, (body) -> new GoalInitiation(body))
			initiations.fetch()
			initiations

	App.reqres.setHandler "goal:initiation:entities:my", () -> API.listMy()