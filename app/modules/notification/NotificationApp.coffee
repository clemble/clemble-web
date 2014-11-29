require './list/NotificationList'
require './entities/NotificationEntities'

@App.module "NotificationApp", (NotificationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false