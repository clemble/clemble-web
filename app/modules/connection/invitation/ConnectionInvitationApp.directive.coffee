angular.
	module('clemble.invitation').
	directive 'clConnectionInvitation',  () ->
		{
			restrict: 'E'
			scope: {
				player: "@player"
				size: "@size"
			}
			templateUrl: 'connection/invitation/cl-player-invitation.html'
			controller: "ConnectionInvitationCtrl"
		}