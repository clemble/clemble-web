angular.
	module('cl.connection.count').
	directive('clConnectionCount',  () ->
		{
			restrict: 'E'
			scope: {
				player: "@player"
			}
			templateUrl: 'connection/count/cl-connection-count.html'
			controller: "ConnectionCountController"
		}
	)