angular.
	module('registration.login').
	directive 'clLogin', () ->
		{
			restrict: 'E'
			templateUrl: 'registration/login/cl-login.html'
			controller: 'RegistrationLoginController'
		}
