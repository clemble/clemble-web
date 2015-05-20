RegistrationLoginController = ($scope, $location, login, ClembleError) ->
	self = @

	self.model = new login
	self.save = () ->
		console.log("Save Pressed")
		if (!$scope.form.$valid)
			console.log("Invalid")
		else
			console.log("Saving #{JSON.stringify(self.model)}")
			self.model.$save(
				() -> window.location = '#goal',
				(error) ->
					if (error.data?)
						_.each(error.data.fields, (e) ->
							if($scope.form[e.field].$validators[e.code]?)
								$scope.form[e.field].$dirty = true
								$scope.form[e.field].$setValidity(e.code, false)
							else
								console.error("#{e.code} validator is missing")
								new ClembleError({
									location  : window.location.toString()
									module    : 'registration'
									field     : e.field
									code      : e.code
									error     : "Validator #{e.code} for #{e.field} is missing"
								}).$save()
						)
					else
						$scope.form.$setValidity("server", false)
			)

RegistrationLoginController.$inject = ['$scope', '$location', 'RegistrationLogin', 'ClembleError']

angular.
	module('registration.login').
	controller('RegistrationLoginController', RegistrationLoginController)


