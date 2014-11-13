require './entities/PlayerConnectionEntities'
require './show/PlayerConnectionShow'

require './invitation/PlayerConnectionInvitationApp'

@App.module "PlayerApp.PlayerConnectionApp", (PlayerConnectionApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false