@App.module "NotificationApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	PLAYER = App.player

	class Notification extends Backbone.Model
		defaults:
			player : null
		initialize      : () ->
			self = @
			@on "change:bank", @checkMy
			@on "change:player", @checkMy
			@checkMy()
		checkMy  : () =>
			if(@get("player") == PLAYER)
				@set('my', true)
			if(@get("bank")?)
				for playerBid in @get("bank").bids
					if (playerBid.player == PLAYER)
						@set('myBid', playerBid.bid)

	class Notifications extends Backbone.Collection
		model: Notification

	API=
		listMy: () ->
			notifications = new Notifications()
			notifications.url = App.Utils.toUrl("/notification/my")
			App.on "notification", (t) ->
				notifications.add(new Notification(t), {at : 0})
			App.on "notification:my", (t) ->
				notifications.add(new Notification(t), {at : 0})
			notifications.fetch()
			notifications

	App.reqres.setHandler "notification:entities:my", () -> API.listMy()