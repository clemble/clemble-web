@App.module "SettingsApp.Password", (Show, App, Backbone, Marionette, $, _) ->

	angular.
		module('settings.password', ['validation.match', 'ngResource']).
		config(($httpProvider) -> $httpProvider.defaults.withCredentials = true)

	SettingsPasswordController = ($scope, password) ->
		$scope.saveButton = "Save"
		$scope.changePassword = () ->
			if (!$scope.passwordForm.$valid)
				$scope.saveButton = "Invalid"
			else
				$scope.saveButton = "Saving ..."
				password.save($scope.m, () ->
					$scope.m = {}
					$scope.saveButton = "Done"
				, () ->
					$scope.saveButton = "Invalid"
				)
	angular.
		module('settings.password').
		factory('SettingsPassword', ['$resource', ($resource) ->
			$resource(App.Utils.toUrl("registration", "change"))
		])

	angular.
		module('settings.password').
		controller('SettingsPasswordController', ['$scope', 'SettingsPassword', SettingsPasswordController])


	App.reqres.setHandler "settings:password", (region) ->
		console.log("Provided region #{region.$el}")
		angular.bootstrap(region.el, ['ngMessages', 'settings.password'])