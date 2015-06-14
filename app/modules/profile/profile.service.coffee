ProfileService = ($resource) ->
	$resource(App.Utils.toUrl("profile", ":player"), { player : '@id' })

angular.
	module('cl.profile').
	service("ProfileService", ProfileService)