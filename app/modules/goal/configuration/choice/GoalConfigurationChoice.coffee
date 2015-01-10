@App.module "GoalConfigurationApp.Choice", (Choice, App, Backbone, Marionette, $, _) ->

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
				'btn  btn-primary'
		initialize: () ->
			self = @
			@model.collection.on "selected", () -> self.render()
		modelEvents:
			'sync' : 'render'
		events:
			'click': () -> @model.collection.setSelected(@model)


	class BidRule extends RuleSelection
		template: require './templates/bid_rule'

	class BidRules extends Marionette.CompositeView
		template: require './templates/bid_rules'
		childView: BidRule
		childViewContainer: "#content"


	class TimeoutRule extends RuleSelection
		template: require './templates/timeout_rule'

	class TimeoutRules extends Marionette.CompositeView
		template: require './templates/timeout_rules'
		childView: TimeoutRule
		childViewContainer: "#content"


	Controller =
		listChoices: (choice, region) ->
			layout = new GoalConfigurationChoiceLayout
			layout.on "show", () ->

				bidRuleView = new BidRules
					collection: choice.bid
				layout.bidRuleRegion.show bidRuleView

				totalTimeoutRuleView = new TimeoutRules
					collection: choice.totalTimeoutRule
				layout.deadlineRuleRegion.show totalTimeoutRuleView

				moveTimeoutRuleView = new TimeoutRules
					collection: choice.moveTimeoutRule
				layout.updateRuleRegion.show moveTimeoutRuleView

			region.show layout

	App.reqres.setHandler "goal:configuration:choice", (choice, region) -> Controller.listChoices(choice, region)
