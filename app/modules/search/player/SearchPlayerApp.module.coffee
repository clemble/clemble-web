app = angular.module('search.player', ['ngMaterial', 'clemble.directive'])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	clSearchPlayer = require('./cl-search-player')()
	$templateCache.put('search/player/cl-search-player.html', clSearchPlayer);
