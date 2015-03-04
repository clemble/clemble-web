require './entities/PlayerConnectionEntities'
require './list/PlayerConnectionList'

require './invitation/PlayerConnectionInvitationApp'

@App.module "PlayerApp.PlayerConnectionApp", (PlayerConnectionApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false