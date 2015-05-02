require "./list/SettingsSocialList"

@App.module "SettingsSocialApp", (PlayerSocialApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false