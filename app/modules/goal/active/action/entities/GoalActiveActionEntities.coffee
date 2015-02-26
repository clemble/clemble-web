@App.module "GoalActiveActionApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class GoalStatusUpdateAction extends Backbone.Model
		defaults:
			status    : null
		toJSON: () ->
			json = super
			json.type = "goal:management:status:update:action"
			json

	class GoalReachedAction extends Backbone.Model
		defaults:
			status    : null
		toJSON: () ->
			json = super
			json.type = "goal:management:reached"
			json

	class BidAction extends Backbone.Model
		defaults:
			amount    : {}
			interest  : {}

	class BetAction extends Backbone.Model
		default:
			bet : 0
		toJSON: () ->
			json = super
			json.bet = Math.round(json.bet)
			json.type = "player:bet:action"
			json

	class GiveUpAction extends Backbone.Model
		defaults:
			type: "player:action:surrender"

	API=
		newAction: (url) ->
			newAction = new GoalStatusUpdateAction()
			newAction.url = "#{url}/action"
			newAction
		newReached: (url) ->
			newReached = new GoalReachedAction()
			newReached.url = url
			newReached
		newBid: (url) ->
			newBid = new BidAction()
			newBid.url = url
			newBid
		newBet: (url) ->
			newBet = new BetAction()
			newBet.url = url
			newBet
		newSurrender: (url) ->
			giveUpAction = new GiveUpAction()
			giveUpAction.url = "#{url}/action"
			giveUpAction


	App.reqres.setHandler "goal:active:action:entities:new", (url) -> API.newAction(url)
	App.reqres.setHandler "goal:active:action:entities:surrender", (url) -> API.newSurrender(url)
	App.reqres.setHandler "goal:active:action:entities:bid", (url) -> API.newBid(url)
	App.reqres.setHandler "goal:active:action:entities:bet", (url) -> API.newBet(url)
	App.reqres.setHandler "goal:active:action:entities:reached", (url) -> API.newReached(url)