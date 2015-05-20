angular.
	module('registration.social').
	directive 'clSocialLogin', () ->
		{
			restrict: 'E'
			templateUrl: 'registration/social/cl-social-login.html'
			controller: 'RegistrationSocialController'
		}
