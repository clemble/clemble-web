angular.
	module('registration.reset').
	factory('RegistrationReset', ['$resource', ($resource) ->
		$resource(App.Utils.toUrl("registration", "reset"))
	])