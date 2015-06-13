angular.
	module('cl.image.player').
	directive 'clImagePlayer', () ->
		{
			restrict: 'E'
			scope: {
				player: "@player"
				size: "@size"
			}
			templateUrl: 'image/player/cl-image-player.html'
			controller: "ImagePlayerController"
		}
