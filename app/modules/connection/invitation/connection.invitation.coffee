require './connection.invitation.module'
require './connection.invitation.service'
require './connection.invitation.controller'
require './connection.invitation.directive'

@App.module "ConnectionInvitationApp", (PlayerConnectionInvitationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	App.reqres.setHandler "connection:invitation:show", (region) ->

		AngularStarter.start(region, 'cl.connection.invitation', require './invitation')