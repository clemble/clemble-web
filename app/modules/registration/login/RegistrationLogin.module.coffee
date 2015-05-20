app = angular.
	module('registration.login', ['validation.server', 'clemble.error', 'ngMaterial', 'ngMessages', 'ngResource'])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	loginHtml = require('./cl-login')()
	$templateCache.put('registration/login/cl-login.html', loginHtml);
