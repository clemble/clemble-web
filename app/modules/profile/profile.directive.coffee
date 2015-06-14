angular.
	module('cl.profile').
	directive 'clProfile', () ->
		{
			restrict: 'E'
			scope: {
				"player" : "@player"
			}
			templateUrl: 'profile/cl-profile.html'
			controller: "ProfileController"
		}
