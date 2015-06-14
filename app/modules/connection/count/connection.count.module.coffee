app = angular.module('cl.connection.count', [
	'ngMaterial',
	'ngResource',
])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	connectionCount = require('./cl-connection-counts')()
	$templateCache.put('connection/count/cl-connection-count.html', connectionCount);
