app = angular.module('registration.social', ['validation.server', 'clemble.error', 'ngMaterial', 'ngMessages', 'ngResource'])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	loginHtml = require('./cl-social-login')()
	$templateCache.put('registration/social/cl-social-login.html', loginHtml);
