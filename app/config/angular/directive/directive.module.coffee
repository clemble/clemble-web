app = angular.module('cl.directive', ['ngMaterial'])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	loginHtml = require('./cl-player-image')()
	$templateCache.put('directive/cl-player-image.html', loginHtml);
