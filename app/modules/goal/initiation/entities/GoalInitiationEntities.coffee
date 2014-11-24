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
		initialize      : () ->
			self = @
			player = App.player
			@on "all", (evt) -> console.log("Initiation #{evt}")
			@on "change:bank", () ->
				for bid in self.get("bank").bids
					if (bid.player == player)
						self.set('myBet', true)
			@on "change:player", () ->
				if(self.get("player") == player)
					self.set('myBet', true)

	class GoalInitiations extends Backbone.Collection
		model: GoalInitiation
		comparator: 'startDate'

	API =
		listMy: () ->
			initiations = new GoalInitiations()
			initiations.url = App.Utils.toUrl("/construction/initiation/my")
			App.request("listener:subscribe:my", "goal:initiation", initiations, (body) -> new GoalInitiation(body))
			initiations.fetch()
			initiations

		listMyFriend: () ->
			initiations = new GoalInitiations()
			initiations.url = App.Utils.toUrl("/construction/initiation/timeline/my")
			App.request("listener:subscribe", "goal:initiation", initiations, (body) -> new GoalInitiation(body))
			initiations.fetch()
			initiations

	App.reqres.setHandler "goal:initiation:entities:my", () -> API.listMy()
	App.reqres.setHandler "goal:initiation:entities:my:friend", () -> API.listMyFriend()