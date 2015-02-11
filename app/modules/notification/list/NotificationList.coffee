@App.module "NotificationApp.List", (List, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class Notification extends Marionette.ItemView
		template: require './templates/player_notification'
		className: 'row'
		behaviors:
			Delete: {}

	class PaymentNotification extends Marionette.ItemView
		template: require './templates/payment_notification'
		className: 'row'
		behaviors:
			Delete: {}

	class PlayerConnectedNotification extends Marionette.ItemView
		template: require './templates/player_connected'
		className: 'row'
		behaviors:
			Delete: {}

	class PlayerDiscoveredNotification extends Marionette.ItemView
		template: require './templates/player_discovered'
		className: 'row'
		behaviors:
			Delete: {}

	class PlayerInvitedNotification extends Marionette.ItemView
		template: require './templates/player_invited'
		className: 'row'
		events:
			'click #accept'  : 'accept'
			'click #decline' : 'decline'
		accept: () ->
			@process(true)
		decline: () ->
			@process(false)
		process: (accept) ->
			url = App.Utils.toUrl("/connection/my/invitations/#{@model.get('connection')}")
			$.ajax({
				type: 'POST',
				url: url,
				data: JSON.stringify(accept),
				contentType: "application/json",
				dataType: 'json'
			})

	class Notifications extends Marionette.CompositeView
		template: require './templates/player_notifications'
		emptyView: NotificationEmpty
		childView : Notification
		childViewContainer : "#caption"
		collectionEvents:
			"change"  : "render"
		modelEvents:
			"sync"    : "render"
			"change"  : "render"
		getChildView: (item) ->
			if (item.get('type') == "notification:player:invited")
				PlayerInvitedNotification
			else if (item.get('type') == "notification:payment")
				PaymentNotification
			else if (item.get('type') == "notification:player:connected")
				PlayerConnectedNotification
			else if (item.get('type') == "notification:player:discovered")
				PlayerDiscoveredNotification
			else
				Notification

	class NotificationEmpty extends Marionette.ItemView
		template: require './templates/empty_notification_menu'

	class NotificationDropdown extends Marionette.CompositeView
		template: require './templates/player_notification_menu'
		childView : Notification
		childViewContainer : "#caption"
		emptyView: NotificationEmpty
		collectionEvents:
			"change"  : "render"
		behaviors:
			CollectionCountSpan: {}
		getChildView: (item) ->
			if (item.get('type') == "notification:player:invited")
				PlayerInvitedNotification
			else if (item.get('type') == "notification:payment")
				PaymentNotification
			else if (item.get('type') == "notification:player:connected")
				PlayerConnectedNotification
			else if (item.get('type') == "notification:player:discovered")
				PlayerDiscoveredNotification
			else
				Notification

	class NotificationNavigation extends Marionette.ItemView
		template: require './templates/player_notification_nav'
		tagName: 'small'
		behaviors:
			CollectionCountSpan: {}


	Controller =
		listMy: (region) ->
			notification = App.request "notification:entities:my"
			notificationView = new Notifications
				collection: notification
			region.show notificationView
		listMyMenu: (region) ->
			notification = App.request "notification:entities:my"
			notificationView = new NotificationDropdown
				collection: notification
			region.show notificationView
		listNavigation: (region) ->
			notification = App.request "notification:entities:my"
			notificationView = new NotificationNavigation
				collection: notification
			region.show notificationView

	App.reqres.setHandler "notification:list:my", (region) -> Controller.listMy(region)
	App.reqres.setHandler "notification:list:my:menu", (region) -> Controller.listMyMenu(region)
	App.reqres.setHandler "notification:list:my:nav", (region) -> Controller.listNavigation(region)