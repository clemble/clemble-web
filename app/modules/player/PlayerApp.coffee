require './profile/PlayerProfileApp'
require './account/PlayerAccountApp'

@App.module "PlayerApp", (PlayerApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false