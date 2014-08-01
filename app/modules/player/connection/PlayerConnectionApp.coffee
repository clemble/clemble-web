require './entities/PlayerConnectionEntities'
require './show/PlayerConnectionShow'

@App.module "PlayerConnectionApp", (PlayerConnectionApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false