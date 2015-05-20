app = angular.module('registration.signIn', ['registration.social', 'registration.login', 'registration.signUp', 'ngMaterial', 'ngMessages'])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

