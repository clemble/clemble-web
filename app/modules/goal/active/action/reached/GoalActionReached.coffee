@App.module "GoalActive.New", (GoalActionSurrender, App, Backbone, Marionette, $, _) ->

	Controller =
		surrender: (url) ->
			reachedAction = App.request "goal:active:action:entities:reached", "#{url}/action"
			reachedModal = new ReachedModal
				model: reachedAction
			App.modal.show reachedModal

	class ReachedModal extends Marionette.ItemView
		template: require './templates/goal_reached_modal'
		behaviors:
			StickIt: {}
			MarionetteModal: {}
		bindings:
			'#status'  : 'status'


	App.reqres.setHandler "goal:active:action:reached", (url) -> Controller.surrender(url)

