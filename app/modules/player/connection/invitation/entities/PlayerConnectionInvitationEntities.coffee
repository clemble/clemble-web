@App.module "PlayerConnectionInvitationApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	class Invitation extends Backbone.Model
		defaults:
			player: null
#		idAttribute: 'player'
		validation: {
			player: {
				required: true
			}
		}

	class Invitations extends Backbone.Collection
		model: Invitation

	API =
		myInvitations: () ->
			invitations = new Invitations
			invitations.url = App.Utils.toUrl("connection", "my/invitations")
			invitations.fetch()
			invitations
		newInvitation: () ->
			invitation = new Invitation
			invitation.url = App.Utils.toUrl("connection", "my/invitations")
			invitation

	App.reqres.setHandler "player:connection:invitation:entities:my", () -> API.myInvitations()
	App.reqres.setHandler "player:connection:invitation:entities:new", () -> API.newInvitation()