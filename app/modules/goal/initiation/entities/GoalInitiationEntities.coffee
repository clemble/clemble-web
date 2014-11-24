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
			API.listenToEvents(initiations, ":my")
			initiations.fetch()
			initiations

		listMyFriend: () ->
			initiations = new GoalInitiations()
			initiations.url = App.Utils.toUrl("/construction/initiation/timeline/my")
			API.listenToEvents(initiations, "")
			initiations.fetch()
			initiations

		listenToEvents: (initiations, postfix) ->
			App.on "goal:initiation:created#{postfix}", (event) ->
				console.log("Adding initiation #{event}")
				initiations.add(new GoalInitiation(event.initiation))
			App.on "goal:initiation:changed#{postfix}", (event) ->
				console.log("Updating initiation #{event}")
				initiationModel = initiations.get(event.initiation.goalKey)
				if (initiationModel?)
					initiationModel.set(event.initiation)
				else
					initiations.add(new GoalInitiation(event.initiation))
			App.on "goal:initiation:complete#{postfix}", (intiation) ->
				console.log("Removing initiation #{intiation}")
				initiations.remove(new GoalInitiation(intiation))

	App.reqres.setHandler "goal:initiation:entities:my", () -> API.listMy()
	App.reqres.setHandler "goal:initiation:entities:my:friend", () -> API.listMyFriend()