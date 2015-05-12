angular.
	module('settings.password', ['validation.match', 'ngMaterial', 'ngMessages', 'ngResource']).
	config(($httpProvider) -> $httpProvider.defaults.withCredentials = true)
