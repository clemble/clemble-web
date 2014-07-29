require './profile/PlayerProfileApp'

@App.module "PlayerApp", (PlayerApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false