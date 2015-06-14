ProfileController = ($scope, ProfileService) ->
	player = $scope.player
	$scope.profile =  ProfileService.get { player : player }
	$scope.$watch "profile", () -> console.log("#{JSON.stringify($scope.profile)}")
	@

angular.
	module('cl.profile').
	controller("ProfileController", ProfileController)