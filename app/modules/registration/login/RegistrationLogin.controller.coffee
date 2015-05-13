RegistrationLoginController = ($scope, $location, login) ->
	self = @

	self.model = new login
	self.saveButton = "Save"
	self.save = (form, model) ->
		console.log("Save Pressed")
		if (!$scope.form.$valid)
			console.log("Invalid")
		else
			console.log("Saving #{JSON.stringify(self.model)}")
			self.model.$save(
				() -> window.location = '#goal',
				(error) ->
					_.each(error.data.fields, (e) ->
						$scope.form[e.field].$dirty = true
						$scope.form[e.field].$setValidity(e.description, false)
					)
			)

RegistrationLoginController.$inject = ['$scope', '$location', 'RegistrationLogin']

angular.
	module('registration.login').
	controller('RegistrationLoginController', RegistrationLoginController)


