@App.module "ConnectionInvitationApp.New", (New, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	Controller =
		newModal: () ->
			invitation = App.request "player:connection:invitation:entities:new"
			invitationView = new InvitationModal
				model: invitation
			App.modal.show invitationView


	class InvitationModal extends Marionette.ItemView
		template: require './templates/new'
		behaviors:
			StickIt: {}
			StickValidation: {}
			MarionetteModal: {}
		bindings:
			'#player'  : 'player'

	App.reqres.setHandler "player:connection:invitation:new:modal", () -> Controller.newModal()