@App.module "GoalActiveActionApp.GoalActiveActionBid", (GoalActiveActionBid, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	Controller =
		newBid: (goalKey, betRule) ->
			if (betRule.betType == "rule:bet:bid:mono")
				monoBid = App.request "goal:active:action:entities:bid", "#{App.Utils.toUrl("/construction/initiation/#{goalKey}/bid")}"
				monoBid.set(betRule.bid)
				newMonoBid = new MonoBid
					model: monoBid
				App.modal.show newMonoBid

	class MonoBid extends Marionette.ItemView
		template: require "./templates/bid_action"
		behaviours:
			StickIt: {}
		events:
			"click #yes" : "bid"
			"click #no"  : "close"
		bid: () ->
			@model.save()
			@close()
		close: () ->
			@$el.parent().parent().parent().parent().modal("hide")

	App.reqres.setHandler "goal:active:action:bid:modal", (goalKey, betRule) -> Controller.newBid(goalKey, betRule)


