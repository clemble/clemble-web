console.log("Creating connection invitation module")

app = angular.module('cl.invitation.connection', ['ngMaterial'])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	playerInvitation = require('./cl-player-invitations')()
	$templateCache.put('connection/invitation/cl-player-invitations.html', playerInvitation);
