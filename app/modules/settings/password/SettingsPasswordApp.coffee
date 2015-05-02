@App.module "SettingsApp.Password", (Show, App, Backbone, Marionette, $, _) ->

	SettingsPassword = ($scope) ->
		$scope.text = "Angular does work"

	angular.
		module('settings.password', []).
		controller('SettingsPassword', [
			'$scope'
			SettingsPassword
		])


	App.reqres.setHandler "settings:password", (region) ->
		console.log("Provided region #{region.$el}")
		angular.bootstrap(region.el, ['settings.password'])