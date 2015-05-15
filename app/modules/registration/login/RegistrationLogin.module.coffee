angular.
	module('registration.login', ['validation.server', 'clemble.error', 'ngMaterial', 'ngMessages', 'ngResource']).
	config(($httpProvider) -> $httpProvider.defaults.withCredentials = true)
