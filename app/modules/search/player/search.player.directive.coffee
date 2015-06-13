angular.
	module('cl.search.player').
	directive('clSearchPlayerAutocomplete', () ->
		{
			restrict    : 'E'
			templateUrl : 'search/player/cl-search-player-autocomplete.html'
			controller  : 'SearchPlayerAutocompleteController'
			controllerAs: 'ctrl'
		}
	).directive('clSearchPlayer', () ->
		{
			restrict    : 'E'
			templateUrl : 'search/player/cl-search-player.html'
			controller  : 'SearchPlayerController'
		}
	)
