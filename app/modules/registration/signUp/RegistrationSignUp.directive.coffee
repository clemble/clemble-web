angular.
	module('registration.signUp').
	directive 'clSignUp', () ->
		{
			restrict: 'E'
			templateUrl: 'registration/signup/cl-signup.html'
			controller: 'RegistrationLoginController'
		}