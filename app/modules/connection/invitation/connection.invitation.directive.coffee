angular.
	module('cl.connection.invitation').
	directive('clConnectionInvitations',  () ->
		{
			restrict: 'E'
			scope: {}
			templateUrl: 'connection/invitation/cl-connection-invitations.html'
			controller: "ConnectionInvitationsController"
		}
	).
	directive('clConnectionInvitation',  () ->
		{
			restrict: 'E'
			templateUrl: 'connection/invitation/cl-connection-invitation.html'
			controller: "ConnectionInvitationController"
		}
	)
