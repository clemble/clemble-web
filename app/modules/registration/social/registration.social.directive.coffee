angular.
	module('registration.social').
	directive 'clSocialLogin', () ->
		{
			restrict: 'E'
			scope: {}
			templateUrl: 'registration/social/cl-social-login.html'
			controller: 'RegistrationSocialController'
		}

angular.
	module('registration.social').
	directive 'clSocialAdd', () ->
		{
			restrict: 'E'
			scope: {}
			templateUrl: 'registration/social/cl-social-add.html'
			controller: 'RegistrationSocialController'
		}
