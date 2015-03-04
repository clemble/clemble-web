@App.module "PlayerApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	class PlayerModal extends Marionette.LayoutView
		template: require './templates/modal_player_layout'
		regions:
			'postRegion' : '#postRegion'

	Controller =
		showModal: (player) ->
			playerModal = new PlayerModal()
			playerModal.on "show", () ->
				App.request "feed:list", player, playerModal.postRegion
			App.modal.show playerModal

	App.reqres.setHandler "player:show:modal", (player) -> Controller.showModal(player)