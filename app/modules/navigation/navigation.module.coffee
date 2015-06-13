app = angular.module('cl.navigation', ['ngMaterial', 'cl.account','cl.search.player'])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	navigationHtml = require('./navigation')()
	$templateCache.put('navigation/navigation.html', navigationHtml);
