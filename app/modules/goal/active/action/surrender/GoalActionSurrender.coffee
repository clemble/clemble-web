@App.module "GoalActionSurrender.New", (GoalActionSurrender, App, Backbone, Marionette, $, _) ->

	Controller =
		surrender: (url) ->
			surrenderAction = App.request "goal:active:action:entities:surrender", url
			surrenderModal = new SurrenderModal(
				model: surrenderAction
			)
			App.modal.show surrenderModal

	class SurrenderModal extends Marionette.ItemView
		template: require './templates/goal_surrender'
		behaviors:
			MarionetteModal: {}


	App.reqres.setHandler "goal:active:action:surrender", (url) -> Controller.surrender(url)

