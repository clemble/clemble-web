app = angular.module('cl.search.player', [
	'ngMaterial',
	'cl.directive',
	'cl.image.player'
])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	clSearchPlayerAutocomplete = require('./cl-search-player-autocomplete')()
	$templateCache.put('search/player/cl-search-player-autocomplete.html', clSearchPlayerAutocomplete);

	clSearchPlayer = require('./cl-search-player')()
	$templateCache.put('search/player/cl-search-player.html', clSearchPlayer);
