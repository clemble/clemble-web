require './SettingsPassword.module'
require './SettingsPassword.service'
require './SettingsPassword.controller'

@App.module "SettingsApp.Password", (Show, App, Backbone, Marionette, $, _) ->

	App.reqres.setHandler "settings:password", (region) ->
		angular.bootstrap(region.el, ['ngMessages', 'settings.password'])