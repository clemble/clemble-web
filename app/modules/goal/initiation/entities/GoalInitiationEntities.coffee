@App.module "GoalInitiationApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class GoalInitiation extends Backbone.Model
		default:
			goalKey       : null
			player        : null
			startDate     : null
			configuration : null
		idAttribute     : 'goalKey'
		urlRoot         : App.Utils.toUrl("/construction/initiation/")
		parse: (initiation) ->
			player = App.player
			if(initiation.player == player)
				initiation.myBet = true
			for bid in initiation.bank.bids
				if(bid.player == player)
					initiation.myBet = true
			initiation


	class GoalInitiations extends Backbone.Collection
		model: GoalInitiation
		comparator: 'startDate'

	API =
		listMy: () ->
			initiations = new GoalInitiations()
			initiations.url = App.Utils.toUrl("/construction/initiation/my")
			App.on "goal:initiation:created", () -> initiations.fetch()
			App.on "goal:initiation:complete", () -> initiations.fetch()
			initiations.fetch()
			initiations
		listMyFriend: () ->
			initiations = new GoalInitiations()
			initiations.url = App.Utils.toUrl("/construction/initiation/timeline/my")
			App.on "goal:initiation:created", () -> initiations.fetch()
			App.on "goal:initiation:complete", () -> initiations.fetch()
			initiations.fetch()
			initiations

	App.reqres.setHandler "goal:initiation:entities:my", () -> API.listMy()
	App.reqres.setHandler "goal:initiation:entities:my:friend", () -> API.listMyFriend()