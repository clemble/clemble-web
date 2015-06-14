angular.
	module('cl.image.player').
	directive 'clImagePlayer', () ->
		{
			restrict: 'E'
			scope: {
				player: "@player"
				height: "@height"
				width : "@width"
			}
			templateUrl: 'image/player/cl-image-player.html'
			controller: "ImagePlayerController"
		}
