app = angular.module('cl.connection.invitation', [
	'ngMaterial',
	'ngResource',
	'cl.image.player',
	'cl.directive'
])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	connectionInvitations = require('./cl-connection-invitation')()
	$templateCache.put('connection/invitation/cl-connection-invitation.html', connectionInvitations);

	connectionInvitations = require('./cl-connection-invitations')()
	$templateCache.put('connection/invitation/cl-connection-invitations.html', connectionInvitations);
