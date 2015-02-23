@App.module "GoalSuggestionApp.List", (List, App, Backbone, Marionette, $, _) ->

	class Suggested extends Marionette.ItemView
		template: require './templates/suggested'
		className: 'row'

	class Suggesteds extends Marionette.CompositeView
		template: require './templates/suggested_all'
		childView : Suggested
		childViewContainer : "#caption"
		emptyView: SuggestionEmpty

	class SuggestionDetails extends Marionette.ItemView
		template: require './templates/suggestion_details'

	class Suggestion extends Marionette.ItemView
		template: require './templates/suggestion'
		className: 'row list-group-item-danger'
		events:
			'click #accept'  : 'accept'
			'click #decline' : 'decline'
		accept: () ->
			self = @
			suggestion = App.request "goal:suggestion:entities:response", @model
			suggestion.set('accepted', true)

			interval = App.request "goal:configuration:entities:interval"
			interval.linkTo(suggestion)

			approveModal = new SuggestionModalLayout
				model: suggestion

			approveModal.on "show", () ->
				App.request "goal:configuration:interval:short", interval, approveModal.configurationRegion
				detailsView = new SuggestionDetails
					model: self.model

				approveModal.goalRegion.show detailsView
			App.modal.show approveModal
		decline: () ->
			suggestion = App.request "goal:suggestion:entities:response", @model
			suggestion.set('accepted', false)
			suggestion.save()

	class SuggestionModalLayout extends Marionette.LayoutView
		template: require './templates/suggestion_modal_layout'
		regions:
			goalRegion          : "#goalRegion"
			configurationRegion : "#configurationRegion"
		behaviors:
			MarionetteModal: {}

	class Suggestions extends Marionette.CollectionView
		className: 'list-group'
		childView : Suggestion
		childViewContainer : "#caption"
		emptyView: SuggestionEmpty
		modelEvents:
			"sync"  : "render"
			"change": "render"

	class SuggestionEmpty extends Marionette.ItemView
		template: require './templates/suggestions_empty'

	class SuggestionLayout extends Marionette.LayoutView
		template: require './templates/suggestion_layout'
		regions:
			suggestionApp     : "#suggestionApp"
			suggestedApp      : "#suggestedApp"

	Controller =
		listMy: (region) ->
			suggestionLayout = new SuggestionLayout
			suggestionLayout.on "show", () ->

				Controller.listMySuggestions(suggestionLayout.suggestionApp)

				suggested = App.request "goal:suggestion:entities:suggested:my"
				suggestedView = new Suggesteds
					collection: suggested
				suggestionLayout.suggestedApp.show suggestedView
			region.show suggestionLayout
		listMySuggestions: (region) ->
			suggestions = App.request "goal:suggestion:entities:list:my"
			suggestionsView = new Suggestions
				collection: suggestions
			region.show suggestionsView

	App.reqres.setHandler "goal:suggestion:list:my", (region) -> Controller.listMy(region)
	App.reqres.setHandler "goal:suggestion:list:my:suggestions", (region) -> Controller.listMySuggestions(region)