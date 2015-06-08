app = angular.module('navigation', ['ngMaterial'])

app.run ($templateCache) ->
	navigationHtml = require('./navigation')()
	$templateCache.put('navigation/navigation.html', navigationHtml);
