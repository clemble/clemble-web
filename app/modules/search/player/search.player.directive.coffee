angular.
	module('cl.search.player').
	directive 'clSearchPlayer', () ->
		{
			restrict: 'E'
			templateUrl: 'search/player/cl-search-player.html'
			controller: 'SearchPlayerController'
			controllerAs: 'ctrl'
		}
