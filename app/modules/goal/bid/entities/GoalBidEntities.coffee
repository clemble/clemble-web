@App.module "GoalBidApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	class Bid extends Backbone.Model
		defaults:
			amount    : null
			interest  : null

	API =
		get: (goal) ->
			bid = new Bid(goal.get("bid"))
			bid

	App.reqres.setHandler "goal:bid:entities:get", (goal) -> API.get(goal)