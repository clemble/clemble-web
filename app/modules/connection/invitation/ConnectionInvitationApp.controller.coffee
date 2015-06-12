ConnectionInvitationCtrl = ($scope, ConnectionInvitation) ->
	@.invitations = ConnectionInvitation.$query()
	@

angular.
	module('clemble.invitation').
	controller('ConnectionInvitationCtrl', ConnectionInvitationCtrl)