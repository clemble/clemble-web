RegistrationLoginController = ($scope, $location, login) ->
	self = @

	self.model = new login
	self.saveButton = "Save"
	self.save = () ->
		console.log("Save Pressed")
		if (!$scope.form.$valid)
			console.log("Invalid")
		else
			console.log("Saving #{JSON.stringify(self.model)}")
			self.model.$save(() -> window.location = '#goal')

RegistrationLoginController.$inject = ['$scope', '$location', 'RegistrationLogin']

angular.
	module('registration.login').
	controller('RegistrationLoginController', RegistrationLoginController)


