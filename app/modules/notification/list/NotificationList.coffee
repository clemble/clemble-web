@App.module "NotificationApp.List", (List, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class Notification extends Marionette.ItemView
		template: require './templates/player_notification'

	class PaymentBonusNotification extends Marionette.ItemView
		template: require './templates/payment_bonus'

	class GoalStartedNotification extends Marionette.ItemView
		template: require './templates/goal_started'

	class GoalCreatedNotification extends Marionette.ItemView
		template: require './templates/goal_created'

	class PlayerConnected extends Marionette.ItemView
		template: require './templates/player_connected'

	class GoalBidNotification extends Marionette.ItemView
		template: require './templates/goal_bid'

	class GoalUpdatedNotification extends Marionette.ItemView
		template: require './templates/goal_update'

	class GoalReachedNotification extends Marionette.ItemView
		template: require './templates/goal_reached'

	class GoalMissedNotification extends Marionette.ItemView
		template: require './templates/goal_missed'

	class Notifications extends Marionette.CompositeView
		template: require './templates/player_notifications'
		childView : Notification
		childViewContainer : "#caption"
		modelEvents:
			"sync" : "render"
		getChildView: (item) ->
			if (item.get('type') == "notification:payment:bonus")
				PaymentBonusNotification
			else if (item.get('type') == "notification:goal:created")
				GoalCreatedNotification
			else if (item.get('type') == "notification:goal:started")
				GoalStartedNotification
			else if (item.get('type') == "notification:player:connected")
				PlayerConnected
			else if (item.get('type') == "notification:goal:bid")
				GoalBidNotification
			else if (item.get('type') == "notification:goal:updated")
				GoalUpdatedNotification
			else if (item.get('type') == "notification:goal:reached")
				GoalReachedNotification
			else if (item.get('type') == "notification:goal:missed")
				GoalMissedNotification
			else
				Notification

	Controller =
		listMy: (region) ->
			notification = App.request "notification:entities:my"
			notificationView = new Notifications
				collection: notification
			region.show notificationView

	App.reqres.setHandler "notification:list:my", (region) -> Controller.listMy(region)