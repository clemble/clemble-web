require './entities/ConnectionInvitationEntities'
require './new/ConnectionInvitationNew'

require './ConnectionInvitationApp.module'
require './ConnectionInvitationApp.controller'
require './ConnectionInvitationApp.directive'

@App.module "ConnectionInvitationApp", (PlayerConnectionInvitationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false