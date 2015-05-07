angular.
	module('settings.password', ['validation.match', 'ngMessages', 'ngResource']).
	config(($httpProvider) -> $httpProvider.defaults.withCredentials = true)
