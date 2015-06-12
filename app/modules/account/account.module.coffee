app = angular.module('cl.account', ['ngMaterial', 'ngResource'])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	navigationHtml = require('./cl-account')()
	$templateCache.put('account/cl-account.html', navigationHtml);