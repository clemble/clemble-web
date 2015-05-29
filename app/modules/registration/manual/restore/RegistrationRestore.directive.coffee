app = angular.module('registration.restore')

app.directive('clRegistrationRestore', () ->
		{
			restrict: 'E'
			templateUrl: 'registration/restore/cl-registration-restore.html'
			scope: {}
			controller: 'RegistrationRestoreController'
		}
	)

app.directive 'clRegistrationRestoreSuccess', () ->
		{
			restrict: 'E'
			templateUrl: 'registration/restore/cl-registration-restore-success.html'
		}