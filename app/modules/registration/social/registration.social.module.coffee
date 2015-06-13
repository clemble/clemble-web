app = angular.module('registration.social', ['validation.server', 'clemble.error', 'ngMaterial', 'ngMessages', 'ngResource'])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	socialRegHtml = require('./cl-social-login')()
	$templateCache.put('registration/social/cl-social-login.html', socialRegHtml);
	socialAllHtml = require('./cl-social-add')()
	$templateCache.put('registration/social/cl-social-add.html', socialAllHtml);
