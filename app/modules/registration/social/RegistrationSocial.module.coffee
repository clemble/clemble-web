angular.
	module('registration.social', ['validation.server', 'clemble.error', 'ngMaterial', 'ngMessages', 'ngResource']).
	config(($httpProvider) -> $httpProvider.defaults.withCredentials = true)
