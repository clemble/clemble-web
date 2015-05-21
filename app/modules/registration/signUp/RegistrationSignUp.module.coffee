app = angular.module('registration.signUp', ['validation.match','ngMaterial', 'ngMessages', 'ngResource', 'clemble.error'])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	loginHtml = require('./cl-signup')()
	$templateCache.put('registration/signup/cl-signup.html', loginHtml);

