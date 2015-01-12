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
			privacyRuleRegion       : "#privacyRuleRegion"
			shareRuleRegion         : "#shareRuleRegion"
			configurationRegion     : "#configurationRegion"


	class RuleSelection extends Marionette.ItemView
		tagName: 'label'
		className: () =>
			if (@model.collection.getSelected() == @model)
				'btn btn-primary active'
			else
				'btn btn-primary'
		initialize: () ->
			self = @
			@listenTo @model.collection, "selected", () ->
				if (self.model.collection.getSelected() == self.model)
					self.$el.addClass('active')
				else
					self.$el.removeClass('active')

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


	class SocialRule extends RuleSelection
		template: require './templates/social_rule'

	class SocialRules extends Marionette.CompositeView
		template: require './templates/social_rules'
		childView: SocialRule
		childViewContainer: "#content"



	class ReminderRule extends RuleSelection
		template: require './templates/reminder_rule'

	class ReminderRules extends Marionette.CompositeView
		template: require './templates/reminder_rules'
		childView: ReminderRule
		childViewContainer: "#content"


	class PrivacyRule extends RuleSelection
		template: require './templates/privacy_rule'

	class PrivacyRules extends Marionette.CompositeView
		template: require './templates/privacy_rules'
		childView: PrivacyRule
		childViewContainer: "#content"


	class RoleRule extends RuleSelection
		template: require './templates/role_rule'

	class RoleRules extends Marionette.CompositeView
		template: require './templates/role_rules'
		childView: RoleRule
		childViewContainer: "#content"


	class Configuration extends Marionette.ItemView
		template: require './templates/configuration'
		modelEvents:
			'sync'    : 'render'
			'change'  : 'render'

	Controller =
		listChoices: (choice, region) ->
			layout = new GoalConfigurationChoiceLayout
				model: choice.configuration
			layout.on "show", () ->

				bidRuleView = new BidRules
					collection: choice.bid
				layout.bidRuleRegion.show bidRuleView

				totalTimeoutRuleView = new TimeoutRules
					collection: choice.totalTimeoutRule
				layout.deadlineRuleRegion.show totalTimeoutRuleView

				socialRuleView = new SocialRules
					collection: choice.shareRule
				layout.shareRuleRegion.show socialRuleView

				privacyRuleView = new PrivacyRules
					collection: choice.privacyRule
				layout.privacyRuleRegion.show privacyRuleView

				configurationRegion = new Configuration
					model: choice.configuration
				layout.configurationRegion.show configurationRegion

#				moveTimeoutRuleView = new TimeoutRules
#					collection: choice.moveTimeoutRule
#				layout.updateRuleRegion.show moveTimeoutRuleView

#				emailReminderRuleView = new ReminderRules
#					collection: choice.emailReminderRule
#				layout.emailReminderRuleRegion.show emailReminderRuleView
#
#				phoneReminderRuleView = new ReminderRules
#					collection: choice.phoneReminderRule
#				layout.phoneReminderRuleRegion.show phoneReminderRuleView

#				supporterRuleView = new RoleRules
#					collection: choice.supporterConfiguration
#				layout.supporterRuleRegion.show supporterRuleView
			region.show layout

	App.reqres.setHandler "goal:configuration:choice", (choice, region) -> Controller.listChoices(choice, region)
