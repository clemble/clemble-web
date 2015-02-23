@App.module "GoalSuggestionApp.New", (New, App, Backbone, Marionette, $, _) ->

	Controller =
		newModal: (url) ->
			suggestionRequest = App.request "goal:suggestion:entities:new", url

			suggestionView = new GoalSuggestionModal
				model: suggestionRequest

			App.modal.show suggestionView

	class GoalSuggestionModal extends Marionette.ItemView
		template: require './templates/goal_suggestion_modal'
		behaviors:
			StickIt: {}
			MarionetteModal: {}
		bindings:
			'#goal'       : 'goal'

	App.reqres.setHandler "goal:suggestion:new:modal", (url) -> Controller.newModal(url)