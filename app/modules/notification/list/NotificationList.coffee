@App.module "NotificationApp.List", (List, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class Notification extends Marionette.ItemView
		template: require './templates/player_notification'

	class PaymentNotification extends Marionette.ItemView
		template: require './templates/payment_notification'

	class PlayerConnectedNotification extends Marionette.ItemView
		template: require './templates/player_connected'

	class PlayerDiscoveredNotification extends Marionette.ItemView
		template: require './templates/player_discovered'

	class Notifications extends Marionette.CompositeView
		template: require './templates/player_notifications'
		childView : Notification
		childViewContainer : "#caption"
		modelEvents:
			"sync" : "render"
		getChildView: (item) ->
			if (item.get('type') == "notification:payment")
				PaymentNotification
			else if (item.get('type') == "notification:player:connected")
				PlayerConnectedNotification
			else if (item.get('type') == "notification:player:discovered")
				PlayerDiscoveredNotification
			else
				Notification

	Controller =
		listMy: (region) ->
			notification = App.request "notification:entities:my"
			notificationView = new Notifications
				collection: notification
			region.show notificationView

	App.reqres.setHandler "notification:list:my", (region) -> Controller.listMy(region)