@App.module "NotificationApp.List", (List, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class Notification extends Marionette.ItemView
		template: require './templates/player_notification'
		className: 'list-group-item'
		behaviors:
			Delete: {}

	class PaymentNotification extends Marionette.ItemView
		template: require './templates/payment_notification'
		className: 'list-group-item'
		behaviors:
			Delete: {}

	class GoalWonPaymentNotification extends Marionette.ItemView
		template: require './templates/goal_won_payment_notification'
		className: 'list-group-item'
		behaviors:
			Delete: {}

	class GoalLostPaymentNotification extends Marionette.ItemView
		template: require './templates/goal_lost_payment_notification'
		className: 'list-group-item'
		behaviors:
			Delete: {}

	class PlayerConnectedNotification extends Marionette.ItemView
		template: require './templates/player_connected'
		className: 'list-group-item'
		behaviors:
			Delete: {}

	class PlayerDiscoveredNotification extends Marionette.ItemView
		template: require './templates/player_discovered'
		className: 'list-group-item'
		behaviors:
			Delete: {}

	class GoalSuggestionNotification extends Marionette.ItemView
		template: require './templates/goal_suggestion_notification'
		className: 'list-group-item'
		behaviors:
			Delete: {}

	class PlayerInvitedNotification extends Marionette.ItemView
		template: require './templates/player_invited'
		className: 'list-group-item'
		events:
			'click #accept'  : 'accept'
			'click #decline' : 'decline'
		accept: () ->
			@process(true)
		decline: () ->
			@process(false)
		process: (accept) ->
			url = App.Utils.toUrl("connection", "my/invitations/#{@model.get('connection')}")
			$.ajax({
				type: 'POST',
				url: url,
				data: JSON.stringify(accept),
				contentType: "application/json",
				dataType: 'json'
			})

	class Notifications extends Marionette.CollectionView
		template: require './templates/player_notifications'
		className : "list-group col-md-offset-3 col-md-6 col-xs-12 thumbnail"
		emptyView: NotificationEmpty
		childView : Notification
		childViewContainer : "#caption"
		collectionEvents:
			"change"  : "render"
		modelEvents:
			"sync"    : "render"
			"change"  : "render"
		getChildView: (item) -> childView(item)

	class NotificationEmpty extends Marionette.ItemView
		template: require './templates/empty_notification'

	class NotificationDropdown extends Marionette.CompositeView
		template: require './templates/player_notification_menu'
		emptyView: NotificationEmpty
		childView : Notification
		childViewContainer : "#caption"
		collectionEvents:
			"change"  : "render"
		behaviors:
			CollectionCountSpan: {}
		getChildView: (item) -> childView(item)

	childView = (item) ->
		if (item.get('type') == "notification:player:invited")
			PlayerInvitedNotification
		else if (item.get('type') == "notification:payment")
			source = item.get('source')
			if (source.type == "payment:goal")
				if (item.get('operation') == "Debit")
					GoalWonPaymentNotification
				else
					GoalLostPaymentNotification
			else
				PaymentNotification
		else if (item.get('type') == "notification:player:connected")
			PlayerConnectedNotification
		else if (item.get('type') == "notification:player:discovered")
			PlayerDiscoveredNotification
		else if (item.get('type') == "notification:goal:suggestion")
			GoalSuggestionNotification
		else
			Notification

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

	App.reqres.setHandler "notification:list:my", (region) -> Controller.listMy(region)
	App.reqres.setHandler "notification:list:my:menu", (region) -> Controller.listMyMenu(region)