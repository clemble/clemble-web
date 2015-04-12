@App.module "GoalSuggestionApp.New", (New, App, Backbone, Marionette, $, _) ->

	Controller =
		newModal: (url) ->
			suggestionRequest = App.request "goal:suggestion:entities:new", url

			suggestionView = new GoalSuggestionModal
				model: suggestionRequest

			App.modal.show suggestionView
		newButton: (player, region) ->
			suggestionButton = new GoalSuggestionButton()
			suggestionButton.suggestionUrl = App.Utils.toUrl("suggestion", "player/#{player}")
			region.show suggestionButton


	class GoalSuggestionButton extends Marionette.ItemView
		template: require './templates/goal_suggestion_button'
		events:
			'click #suggest': () -> App.request "goal:suggestion:new:modal", @suggestionUrl


	class GoalSuggestionModal extends Marionette.ItemView
		template: require './templates/goal_suggestion_modal'
		behaviors:
			StickIt: {}
			MarionetteModal: {}
		bindings:
			'#goal'       : 'goal'

	App.reqres.setHandler "goal:suggestion:new:modal", (url) -> Controller.newModal(url)
	App.reqres.setHandler "goal:suggestion:new:button", (player, region) -> Controller.newButton(player, region)