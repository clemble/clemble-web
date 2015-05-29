angular.
	module('registration.signUp').
	directive 'clSignup', () ->
		{
			restrict: 'E'
			templateUrl: 'registration/signup/cl-signup.html'
			scope: {}
			controller: 'RegistrationSignUpController'
		}