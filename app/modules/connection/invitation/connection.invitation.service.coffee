ConnectionInvitation = ($resource) ->
	$resource(App.Utils.toUrl("connection", "my/invitation"))

angular.
	module('cl.connection.invitation').
	factory('ConnectionInvitation', ['$resource', ConnectionInvitation])