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

	Controller =
		listChoices: (choice, region) ->
			layout = new GoalConfigurationChoiceLayout
			layout.on "show", () ->
				configurationsView = new GoalConfigurationChoice
					model: choice
				layout.bidRuleRegion.show configurationsView
			region.show layout

	App.reqres.setHandler "goal:configuration:choice", (choice, region) -> Controller.listChoices(choice, region)
