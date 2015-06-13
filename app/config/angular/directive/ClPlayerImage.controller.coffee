clPlayerImageCtrl = ($scope) ->

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
	module('cl.directive').
	controller 'clPlayerImageCtrl', clPlayerImageCtrl
