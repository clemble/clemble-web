angular.
	module('clemble.error', ['ngResource']).
	config(($httpProvider) -> $httpProvider.defaults.withCredentials = true)
