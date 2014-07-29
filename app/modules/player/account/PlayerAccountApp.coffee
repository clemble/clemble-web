require './entities/PlayerAccountEntities'
require './show/PlayerAccountShow'

@App.module "PlayerAccountApp", (PlayerAccountApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false