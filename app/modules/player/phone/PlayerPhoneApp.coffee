require "./entities/PlayerPhoneEntities"
require "./new/PlayerPhoneNew"

@App.module "PlayerPhoneApp", (PlayerPhoneApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false