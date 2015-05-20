angular.
	module('registration.signUp').
	factory('RegistrationSignUp', ['$resource', ($resource) ->
		$resource(App.Utils.toUrl("registration", "signin"))
	])