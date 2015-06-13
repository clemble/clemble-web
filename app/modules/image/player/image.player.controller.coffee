ImagePlayerController = ($scope) ->

	$scope.playerImage = (player, size) ->
		if (size?)
			App.Utils.toUrl("profile", "#{player}/image/#{size}")
		else
			App.Utils.toUrl("profile", "#{player}/image")

	$scope.playerSmallImage = (player) ->
		imageUrl = App.Utils.toUrl("profile", "#{player}/image/small")
		imageUrl
	@

angular.
	module('cl.image.player').
	controller 'ImagePlayerController', ImagePlayerController
