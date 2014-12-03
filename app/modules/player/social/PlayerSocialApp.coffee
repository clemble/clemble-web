require "./list/PlayerSocialList"

@App.module "PlayerSocialApp", (PlayerSocialApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false