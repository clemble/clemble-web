require './SettingsPassword.module'
require './SettingsPasswordFactory'
require './SettingsPasswordController'
@App.module "SettingsApp.Password", (Show, App, Backbone, Marionette, $, _) ->

	App.reqres.setHandler "settings:password", (region) ->
		console.log("Provided region #{region.$el}")
		angular.bootstrap(region.el, ['ngMessages', 'settings.password'])