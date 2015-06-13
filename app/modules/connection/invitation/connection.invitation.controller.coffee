ConnectionInvitationCtrl = ($scope, ConnectionInvitation) ->
	@.invitations = ConnectionInvitation.$query()
	@

angular.
	module('cl.invitation.connection').
	controller('ConnectionInvitationCtrl', ConnectionInvitationCtrl)