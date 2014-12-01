@App.module "NotificationApp.List", (List, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class Notification extends Marionette.ItemView
		template: require './templates/player_notification'

	class PaymentBonusNotification extends Marionette.ItemView
		template: require './templates/payment_bonus'

	class PlayerConnectedNotification extends Marionette.ItemView
		template: require './templates/player_connected'

	class Notifications extends Marionette.CompositeView
		template: require './templates/player_notifications'
		childView : Notification
		childViewContainer : "#caption"
		modelEvents:
			"sync" : "render"
		getChildView: (item) ->
			if (item.get('type') == "notification:payment:bonus")
				PaymentBonusNotification
			else if (item.get('type') == "notification:player:connected")
				PlayerConnectedNotification
			else
				Notification

	Controller =
		listMy: (region) ->
			notification = App.request "notification:entities:my"
			notificationView = new Notifications
				collection: notification
			region.show notificationView

	App.reqres.setHandler "notification:list:my", (region) -> Controller.listMy(region)