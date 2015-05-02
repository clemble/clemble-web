require './show/PlayerShow'
require './social/PlayerSocialApp'

@App.module "PlayerApp", (PlayerApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false