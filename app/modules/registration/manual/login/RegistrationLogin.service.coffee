angular.
	module('registration.login').
	factory('RegistrationLogin', ['$resource', ($resource) ->
		$resource(App.Utils.toUrl("registration", "login"))
	])