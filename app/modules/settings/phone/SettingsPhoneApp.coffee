require "./entities/SettingsPhoneEntities"
require "./new/SettingsPhoneNew"

@App.module "PlayerPhoneApp", (PlayerPhoneApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false