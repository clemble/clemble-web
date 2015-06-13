ProfileController = ($scope, Profile) ->
	$scope.profile = Profile.get({ player : $scope.player })
	@

angular.
	module('cl.profile').
	controller("ProfileController", ProfileController)