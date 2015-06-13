app = angular.module('cl.navigation')
app.controller('SideNavigationContoller', ($scope, $mdSidenav, $mdUtil, $log, $location) ->

	$scope.openLeftMenu = () ->
		$mdSidenav('left').toggle()

	$scope.openRightMenu = () ->
		$mdSidenav('right').toggle()

	$scope.goTo = (link) ->
		$mdSidenav('left').close()
		$location.path(link)

	$scope.$watch 'selectedPlayer', () =>
		if ($scope.selectedPlayer?)
			$mdSidenav('right').close()
			window.location = "#player/#{$scope.selectedPlayer}"

	buildToggler = (navID) ->
		debounceFn =  $mdUtil.debounce(() ->
				$mdSidenav(navID).toggle()
			,
			300
		)

		debounceFn

	$scope.toggleLeft = buildToggler('left');
	$scope.toggleRight = buildToggler('right');

)