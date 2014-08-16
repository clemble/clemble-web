require './entities/PlayerProfileEntities'
require './new/PlayerProfileNew'
require './show/PlayerProfileShow'

@App.module "PlayerProfileApp", (PlayerProfileApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false