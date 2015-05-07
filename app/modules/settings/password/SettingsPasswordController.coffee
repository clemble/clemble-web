SettingsPasswordController = ($scope, password) ->
	vm = @

	vm.saveButton = "Save"
	vm.changePassword = () ->
		if (!$scope.passwordForm.$valid)
			vm.saveButton = "Invalid"
		else
			vm.saveButton = "Saving ..."
			password.save(vm.m, () ->
				vm.m = {}
				vm.saveButton = "Done"
			, () ->
				vm.saveButton = "Invalid"
			)

SettingsPasswordController.$inject = ['$scope', 'SettingsPassword']

angular.
	module('settings.password').
	controller('SettingsPasswordController', SettingsPasswordController)


