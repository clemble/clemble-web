require './entities/PlayerConnectionInvitationEntities'
require './new/PlayerConnectionInvitationNew'

@App.module "PlayerConnectionInvitationApp", (PlayerConnectionInvitationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false