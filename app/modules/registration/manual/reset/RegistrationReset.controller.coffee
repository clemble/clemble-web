RegistrationResetController = ($scope, reset, ClembleError) ->
	$scope.model = new reset
	$scope.save = () ->
		if ($scope.form.$valid)
			$scope.model.$save(
				() -> window.location = '#registration/reset/success',
				(error) ->
					if (error.data?)
						_.each(error.data.fields, (e) ->
							if ($scope.form[e.field]?)
								if($scope.form[e.field].$validators[e.code]?)
									$scope.form[e.field].$dirty = true
									$scope.form[e.field].$setValidity(e.code, false)
								else
									console.error("#{e.code} validator is missing")
									new ClembleError({
										location  : window.location.toString()
										module    : 'registration'
										field     : e.field
										type      : 'validationMissing'
										code      : e.code
										error     : "Validator #{e.code} for #{e.field} is missing"
									}).$save()
							else
								new ClembleError({
									location  : window.location.toString()
									module    : 'registration'
									field     : e.field
									type      : 'fieldMissing'
									code      : e.code
									error     : "Validator #{e.code} for #{e.field} is missing"
								}).$save()
						)
					else
						$scope.form.$setValidity("server", false)
			)

RegistrationResetController.$inject = ['$scope', 'RegistrationReset', 'ClembleError']

angular.
	module('registration.reset').
	controller('RegistrationResetController', RegistrationResetController)


