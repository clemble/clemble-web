RegistrationLoginController = ($scope, login, ClembleError) ->
	$scope.model = new login
	$scope.save = () ->
		if ($scope.form.$valid)
			$scope.model.$save(
				() ->
					# Trigger registered event, to launch application
					App.trigger("registered")
				,
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
		else
			console.log("Invalid form")

RegistrationLoginController.$inject = ['$scope', 'RegistrationLogin', 'ClembleError']

angular.
	module('registration.login').
	controller('RegistrationLoginController', RegistrationLoginController)


