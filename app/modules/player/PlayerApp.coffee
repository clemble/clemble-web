require './show/PlayerShow'

@App.module "PlayerApp", (PlayerApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false