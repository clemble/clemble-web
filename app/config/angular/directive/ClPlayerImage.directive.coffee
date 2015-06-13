angular.
	module('cl.directive').
	directive 'clPlayerImage', () ->
		{
			restrict: 'E'
			scope: {
				player: "@player"
				size: "@size"
			}
			templateUrl: 'directive/cl-player-image.html'
			controller: "clPlayerImageCtrl"
		}
