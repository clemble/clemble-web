ConnectionCountController = ($scope, ConnectionCountService) ->
	$scope.count = ConnectionCountService.get({ player : $scope.player })
	$scope.$watch "count", () -> console.log("Count changed #{JSON.stringify($scope.count)}")
	@

angular.
	module('cl.connection.count').
	controller('ConnectionCountController', ConnectionCountController)