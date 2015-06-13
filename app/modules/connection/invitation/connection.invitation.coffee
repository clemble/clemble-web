require './connection.invitation.module'
require './connection.invitation.service'
require './connection.invitation.controller'
require './connection.invitation.directive'

@App.module "ConnectionInvitationApp", (PlayerConnectionInvitationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	console.log("Creating connection invitation service")