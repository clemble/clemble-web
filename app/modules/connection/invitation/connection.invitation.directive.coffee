console.log("Creating connection invitation directive")

angular.
	module('cl.invitation.connection').
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