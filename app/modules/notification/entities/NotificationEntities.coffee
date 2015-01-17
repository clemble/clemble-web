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

	API=
		listMy: () ->
			notifications = new Notifications()
			notifications.url = App.Utils.toUrl("/notification/my")
			App.on "notification", (t) ->
#				notifications.remove(t.key)
				notifications.add(new Notification(t), {at : 0})
			App.on "notification:my", (t) ->
#				notifications.remove(t.key)
				notifications.add(new Notification(t), {at : 0})
			notifications.fetch()
			notifications

	App.reqres.setHandler "notification:entities:my", () -> API.listMy()