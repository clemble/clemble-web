angular.
	module('clemble.invitation').
	factory('ConnectionInvitation', ['$resource', ($resource) ->
		$resource(App.Utils.toUrl("connection", "my/invitation"))
	])