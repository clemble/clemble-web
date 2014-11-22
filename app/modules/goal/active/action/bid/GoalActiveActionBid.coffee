@App.module "GoalActiveActionApp.GoalActiveActionBid", (GoalActiveActionBid, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	Controller =
		newBid: (url, betRule) ->
			if (betRule.betType == "rule:bet:bid:mono")
				monoBid = App.request "goal:active:action:entities:bid", "#{url}/bid"
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

	App.reqres.setHandler "goal:active:action:bid:modal", (url, betRule) -> Controller.newBid(url, betRule)


