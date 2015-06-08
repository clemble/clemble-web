app = angular.module('navigation')
app.controller('SideNavigationContoller', ($scope, $mdSidenav, $location) ->
	$scope.openLeftMenu = () ->
		$mdSidenav('left').toggle()
	$scope.goTo = (link) ->
		$mdSidenav('left').close()
		$location.path(link)
)