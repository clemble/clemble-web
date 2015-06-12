app = angular.module('clemble.invitation', ['ngMaterial'])

app.config ($httpProvider) ->
	$httpProvider.defaults.withCredentials = true

app.run ($templateCache) ->
	playerInvitation = require('./cl-player-invitations')()
	$templateCache.put('connection/invitation/cl-player-invitations.html', playerInvitation);
