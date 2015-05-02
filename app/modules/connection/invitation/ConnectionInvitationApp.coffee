require './entities/ConnectionInvitationEntities'
require './new/ConnectionInvitationNew'

@App.module "ConnectionInvitationApp", (PlayerConnectionInvitationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false