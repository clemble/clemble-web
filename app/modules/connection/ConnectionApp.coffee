require './entities/ConnectionEntities'
require './list/ConnectionList'

require './invitation/connection.invitation'
require './count/connection.count'

@App.module "ConnectionApp", (ConnectionApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false