app = angular.module('registration.reset')

app.directive('clRegistrationReset', () ->
		{
			restrict: 'E'
			templateUrl: 'registration/reset/cl-registration-reset.html'
			scope: {}
			controller: 'RegistrationResetController'
		}
	)

app.directive 'clRegistrationResetSuccess', () ->
		{
			restrict: 'E'
			templateUrl: 'registration/reset/cl-registration-reset-success.html'
		}