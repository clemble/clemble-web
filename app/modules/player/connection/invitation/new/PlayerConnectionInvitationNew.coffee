@App.module "PlayerConnectionInvitationApp.New", (New, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	Controller =
		newModal: () ->
			invitation = App.request "player:connection:invitation:entities:new"
			invitationView = new Invitation
				model: invitation
			App.modal.show invitationView


	class Invitation extends Marionette.ItemView
		template: require './templates/new'
		behaviors:
			StickIt: {}
			StickValidation: {}
		bindings:
			'#player'  : 'player'
		events:
			"click #save": () -> @model.save()

	App.reqres.setHandler "player:connection:invitation:new:modal", () -> Controller.newModal()