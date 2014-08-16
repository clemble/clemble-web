@App.module "GoalBidApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->

	Controller =
		show: (goal, region) ->
			bid = App.request "goal:bid:entities:get", goal
			bidView = new Bid
				model: bid
			region.show bidView

	class Bid extends Marionette.ItemView
		template: require './templates/bid'

	App.reqres.setHandler "goal:bid:show", (goal, region) -> Controller.show(goal, region)