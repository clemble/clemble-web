AccountController = ($scope, AccountService) ->
	player = $scope.player
	$scope.account = AccountService.get({ player: player })
	@

angular.
	module('cl.account').
	controller("AccountController", AccountController)