app = angular.module('registration.reset', ['validation.server', 'clemble.error', 'ngMaterial', 'ngMessages', 'ngResource'])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	resetHtml = require('./cl-registration-reset')()
	$templateCache.put('registration/reset/cl-registration-reset.html', resetHtml);

	resetSuccessHtml = require('./cl-registration-reset-success')()
	$templateCache.put('registration/reset/cl-registration-reset-success.html', resetSuccessHtml);

