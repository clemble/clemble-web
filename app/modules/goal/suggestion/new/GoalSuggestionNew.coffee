@App.module "GoalSuggestionApp.New", (New, App, Backbone, Marionette, $, _) ->

	Controller =
		newModal: (url) ->
			configurations = App.request "goal:configuration:entities:interval"
			suggestionRequest = App.request "goal:suggestion:entities:new:interval", url, configurations

			layout = new GoalSuggestionNewModal
				model: suggestionRequest

			layout.on "show", () ->
				App.request "goal:configuration:interval:short", configurations, layout.configurationRegion

				goal = new GoalSuggestionNew
					model: suggestionRequest

				layout.goalRegion.show goal

			App.modal.show layout

	class GoalSuggestionNew extends Marionette.ItemView
		template: require './templates/goal_suggestion'
		behaviors:
			StickIt: {}
		bindings: {
			'#goal'       : 'goal'
		}

	class GoalSuggestionNewModal extends Marionette.LayoutView
		template: require "./templates/goal_suggest_new_modal"
		regions:
			goalRegion          : "#goalRegion"
			configurationRegion : "#configurationRegion"
		behaviors: {
			MarionetteModal: {}
		}

	App.reqres.setHandler "goal:suggestion:new:modal", (url) -> Controller.newModal(url)