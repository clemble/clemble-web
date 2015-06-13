console.log("Creating connection invitation service")

angular.
	module('cl.invitation.connection').
	factory('ConnectionInvitation', ['$resource', ($resource) ->
		$resource(App.Utils.toUrl("connection", "my/invitation"))
	])