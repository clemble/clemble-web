require './entities/PlayerProfileEntities'
require './new/PlayerProfileNew'

@App.module "PlayerProfileApp", (PlayerProfileApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false