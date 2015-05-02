require './entities/ConnectionEntities'
require './list/ConnectionList'

require './invitation/ConnectionInvitationApp'

@App.module "ConnectionApp", (ConnectionApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false