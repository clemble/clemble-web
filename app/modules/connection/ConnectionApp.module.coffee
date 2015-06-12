app = angular.module('clemble.connection', ['ngMaterial', 'connection.invitation'])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	navigationHtml = require('./connection')()
	$templateCache.put('connection/connection.html', navigationHtml);
