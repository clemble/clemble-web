@App.module "GoalSuggestionApp.List", (List, App, Backbone, Marionette, $, _) ->

	class Suggested extends Marionette.ItemView
		template: require './templates/suggested'
		className: 'row'

	class Suggesteds extends Marionette.CompositeView
		template: require './templates/suggested_all'
		childView : Suggested
		childViewContainer : "#caption"
		emptyView: SuggestionEmpty

	class Suggestion extends Marionette.ItemView
		template: require './templates/suggestion'
		className: 'row list-group-item-danger'
		events:
			'click #accept'  : 'accept'
			'click #decline' : 'decline'
		accept: () ->
			url = App.Utils.toUrl("/suggestion/player/my/#{@model.get('goalKey')}")
			suggestion = App.request "goal:suggestion:entities:response", url
			approveModal = new SuggestionModalLayout
			approveModal.on "show", () ->
				interval = App.request "goal:configuration:entities:interval"
				App.request "goal:configuration:interval:short", interval, approveModal.configurationRegion
			App.modal.show approveModal
		decline: () ->
			url = App.Utils.toUrl("/suggestion/player/my/#{@model.get('goalKey')}")
			suggestion = App.request "goal:suggestion:entities:response", url
			suggestion.set('accepted', false)
			suggestion.save()

	class SuggestionModalLayout extends Marionette.LayoutView
		template: require './templates/suggestion_modal_layout'
		regions:
			goalRegion          : "#goalRegion"
			configurationRegion : "#configurationRegion"

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