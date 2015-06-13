angular.
	module('registration.login').
	directive 'clLogin', () ->
		{
			restrict: 'E'
			scope: {}
			templateUrl: 'registration/login/cl-login.html'
			controller: 'RegistrationLoginController'
		}
