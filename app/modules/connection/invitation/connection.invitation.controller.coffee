ConnectionInvitationsController = ($scope, ConnectionInvitation) ->
	$scope.invitations = ConnectionInvitation.query()
	@

ConnectionInvitationController = ($scope, ConnectionInvitation) ->
	console.log("#{$scope.player}")

angular.
	module('cl.connection.invitation').
	controller('ConnectionInvitationsController', ConnectionInvitationsController).
	controller('ConnectionInvitationController', ConnectionInvitationController)