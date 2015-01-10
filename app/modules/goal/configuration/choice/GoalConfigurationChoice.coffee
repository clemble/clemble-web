@App.module "GoalConfigurationApp.Choice", (Choice, App, Backbone, Marionette, $, _) ->

	class GoalConfigurationChoice extends Marionette.ItemView
		template: require './templates/choices'
		modelEvents:
			'sync'    : 'render'
			'change'  : 'render'

	class GoalConfigurationChoiceLayout extends Marionette.LayoutView
		template: require './templates/choice_layout'
		regions:
			bidRuleRegion           : "#bidRuleRegion"
			deadlineRuleRegion      : "#deadlineRuleRegion"
			updateRuleRegion        : "#updateRuleRegion"
			emailReminderRuleRegion : "#emailReminderRuleRegion"
			phoneReminderRuleRegion : "#phoneReminderRuleRegion"
			supporterRuleRegion     : "#supporterRuleRegion"
			observerRuleRegion      : "#observerRuleRegion"
			privacyRuleRegion       : "#privacyRuleRegion"
			shareRuleRegion         : "#shareRuleRegion"

	class RuleSelection extends Marionette.ItemView
		tagName  : 'label'
		className: () ->
			if (@model.collection.getSelected() == @model)
				'btn btn-primary plan-tall'
			else
				'btn btn-primary'
		modelEvents:
			'sync' : 'render'
		events:
			'click': () -> @model.collection.setSelected(@model)

	class BidRule extends RuleSelection
		template: require './templates/bid_rule'
		modelEvents:
			'sync' : 'render'

	class BidRules extends Marionette.CompositeView
		template: require './templates/bid_rules'
		childView: BidRule
		childViewContainer: "#content"

	Controller =
		listChoices: (choice, region) ->
			layout = new GoalConfigurationChoiceLayout
			layout.on "show", () ->
				bidRuleView = new BidRules
					collection: choice.bid
				layout.bidRuleRegion.show bidRuleView
			region.show layout

	App.reqres.setHandler "goal:configuration:choice", (choice, region) -> Controller.listChoices(choice, region)
