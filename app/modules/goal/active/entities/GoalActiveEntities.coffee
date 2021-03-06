
@App.module "GoalActiveApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class GoalState extends Backbone.Model
		default:
			goalKey       : null
			player        : null
			configuration : null
			status        : null
			context       : null
		idAttribute: 'goalKey'
		urlRoot:
			App.Utils.toUrl('goal', 'active')
		parse: (res) ->
			if (res.bank?)
				myBet = _.find(res.bank.bets, (bet) -> bet.player == App.player)
				if (myBet?)
					res.myBet = myBet.bet
			res


	class GoalStates extends Backbone.Collection
		model: GoalState

	MY = new GoalStates()
	MY.url  = App.Utils.toUrl('goal', 'player/active/my')
	App.request("listener:subscribe:my", "goal:management", MY, (body) ->
		new GoalState(API.getId(body))
	)
	MY.fetch()
	App.once "registered", () -> MY.fetch()


	API =
		getId: (res) ->
			if (res.goalKey?)
				res.id = res.goalKey
			if (res.bank?)
				myBet = _.find(res.bank.bets, (bet) -> bet.player == App.player)
				if (myBet?)
					res.my = true
					res.myBet = myBet.bet
			res
		myActive: () ->
			MY

	App.reqres.setHandler "goal:active:entities:my", () -> API.myActive()