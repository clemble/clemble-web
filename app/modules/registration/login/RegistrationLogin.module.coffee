angular.
	module('registration.login', ['ngMaterial', 'ngMessages', 'ngResource']).
	config(($httpProvider) -> $httpProvider.defaults.withCredentials = true)
