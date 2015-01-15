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
		newSurrender: (url) ->
			giveUpAction = new GiveUpAction()
			giveUpAction.url = "#{url}/action"
			giveUpAction


	App.reqres.setHandler "goal:active:action:entities:new", (url) -> API.newAction(url)
	App.reqres.setHandler "goal:active:action:entities:surrender", (url) -> API.newSurrender(url)
	App.reqres.setHandler "goal:active:action:entities:bid", (url) -> API.newBid(url)
	App.reqres.setHandler "goal:active:action:entities:reached", (url) -> API.newReached(url)