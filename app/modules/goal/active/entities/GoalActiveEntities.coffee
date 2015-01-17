
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
			App.Utils.toUrl('/management/active/')
		parse: (res) ->
			if (res.bank?)
				myBet = _.find(res.bank.bets, (bet) -> bet.player == App.player)
				if (myBet?)
					res.myBet = myBet.bet
			res


	class GoalStates extends Backbone.Collection
		model: GoalState

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
			active = new GoalStates()
			active.url  = App.Utils.toUrl('/management/player/active/my')
			App.request("listener:subscribe:my", "goal:management", active, (body) ->
				new GoalState(API.getId(body))
			)
			active.fetch()
			active

	App.reqres.setHandler "goal:active:entities:my", () -> API.myActive()