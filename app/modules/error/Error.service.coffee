angular.
	module('clemble.error').
	factory('ClembleError', ['$resource', ($resource) ->
		$resource(App.Utils.toUrl("log", "error"))
	])
