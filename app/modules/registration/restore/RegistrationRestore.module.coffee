app = angular.module('registration.restore', ['validation.server', 'clemble.error', 'ngMaterial', 'ngMessages', 'ngResource'])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	restoreHtml = require('./cl-registration-restore')()
	$templateCache.put('registration/restore/cl-registration-restore.html', restoreHtml);

	restoreSuccessHtml = require('./cl-registration-restore-success')()
	$templateCache.put('registration/restore/cl-registration-restore-success.html', restoreSuccessHtml);

