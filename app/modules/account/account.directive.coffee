angular.
	module('cl.account').
	directive 'clAccount', () ->
		{
			restrict: 'E'
			scope: {
				player: "@player"
			}
			templateUrl: 'account/cl-account.html'
			controller: 'AccountController'
		}