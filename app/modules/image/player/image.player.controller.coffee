ImagePlayerController = ($scope) ->

	$scope.playerImage = (player, height, width) ->
		App.Utils.toUrl("profile", "#{player}/image?height=#{height}&width=#{width}")

	$scope.playerSmallImage = (player) ->
		imageUrl = App.Utils.toUrl("profile", "#{player}/image/small")
		imageUrl
	@

angular.
	module('cl.image.player').
	controller 'ImagePlayerController', ImagePlayerController
