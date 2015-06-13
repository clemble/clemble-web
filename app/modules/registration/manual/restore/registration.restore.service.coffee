angular.
	module('registration.restore').
	factory('RegistrationRestore', ['$resource', ($resource) ->
		$resource(App.Utils.toUrl("registration", "restore"))
	])