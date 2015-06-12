app = angular.module('navigation', ['ngMaterial', 'cl.account', 'search.player'])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	navigationHtml = require('./navigation')()
	$templateCache.put('navigation/navigation.html', navigationHtml);
