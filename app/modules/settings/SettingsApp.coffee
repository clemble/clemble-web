require './show/SettingsShow'
require './phone/SettingsPhoneApp'
require './social/SettingsSocialApp'
require './password/SettingsPasswordApp'

@App.module "SettingsApp", (SettingsApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		listSettings: ->
			App.request "settings:show", App.contentRegion

	class SettingsRouter extends Marionette.AppRouter
		appRoutes:
			'settings': 'listSettings'

	App.addInitializer ->
		new SettingsRouter
			controller: API