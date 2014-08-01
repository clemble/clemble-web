require './profile/PlayerProfileApp'
require './account/PlayerAccountApp'
require './connection/PlayerConnectionApp'

@App.module "PlayerApp", (PlayerApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false