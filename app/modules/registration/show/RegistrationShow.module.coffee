app = angular.module('registration', ['registration.social', 'registration.login', 'ngMaterial', 'ngMessages'])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

