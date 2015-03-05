@App.module "NotificationApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	PLAYER = App.player

	class Notification extends Backbone.Model
		defaults:
			player : null
		idAttribute: 'key'
		initialize      : () ->
			self = @
			@on "change:bank", @checkMy
			@on "change:player", @checkMy
			@checkMy()
		checkMy  : () =>
			if(@get("player") == PLAYER)
				@set('my', true)
			if(@get("bank")?)
				for playerBet in @get("bank").bets
					if (playerBet.player == PLAYER)
						@set('myBet', playerBet.bet)

	class Notifications extends Backbone.Collection
		model: Notification
		url: App.Utils.toUrl("/notification/my")
		fetchIfNeeded: () ->
			if (!@fetched)
				@fetched = true
				@fetch()

	NOTIFICATION = new Notifications()
	App.on "notification", (t) ->
		NOTIFICATION.add(new Notification(t), {at : 0})
	App.on "notification:my", (t) ->
		NOTIFICATION.add(new Notification(t), {at : 0})

	App.once "registered", () -> NOTIFICATION.fetch()

	API=
		listMy: () ->
			NOTIFICATION.fetchIfNeeded()
			NOTIFICATION

	App.reqres.setHandler "notification:entities:my", () -> API.listMy()