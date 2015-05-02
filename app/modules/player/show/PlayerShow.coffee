@App.module "PlayerApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	class PlayerModal extends Marionette.LayoutView
		template: require './templates/modal_player_layout'
		regions:
			postRegion          : '#postRegion'
			profileRegion       : '#profileRegion'
			accountRegion       : '#accountRegion'
			suggestButtonRegion : '#suggestButtonRegion'
		events:
			'click #suggest': () -> App.request "player:connection:invitation:new:modal"

	Controller =
		showModal: (player) ->
			playerModal = new PlayerModal()
			playerModal.on "show", () ->
				App.request "feed:list", player, playerModal.postRegion
				App.request "profile:show", player, playerModal.profileRegion
				App.request "account:show", player, playerModal.accountRegion
				App.request "goal:suggestion:new:button", player, playerModal.suggestButtonRegion
			App.modal.show playerModal

	App.reqres.setHandler "player:show:modal", (player) -> Controller.showModal(player)