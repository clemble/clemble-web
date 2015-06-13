require './entities/ConnectionEntities'
require './list/ConnectionList'

require './invitation/connection.invitation'

@App.module "ConnectionApp", (ConnectionApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false