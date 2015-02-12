require './list/NotificationList'
require './entities/NotificationEntities'

@App.module "NotificationApp", (NotificationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		listSettings: ->
			App.request "notification:list:my", App.contentRegion

	class GoalNotificationRouter extends Marionette.AppRouter
		appRoutes:
			'notification': 'listSettings'

	App.addInitializer ->
		new GoalNotificationRouter
			controller: API