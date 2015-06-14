app = angular.module('cl.profile', [
	'ngMaterial',
	'ngResource',
	'cl.image.player',
	'cl.account'
])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	profileHtml = require('./cl-profile')()
	$templateCache.put('profile/cl-profile.html', profileHtml);
