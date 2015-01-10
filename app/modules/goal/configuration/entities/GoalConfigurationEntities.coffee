@App.module "GoalConfigurationApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->


	class GoalConfiguration extends Backbone.Model
		defaults:
			configurationKey: null
			privacyRule: null
			moveTimeRule: null
			totalTimeRule: null
		idAttribute: "configurationKey"

	class Value extends Backbone.Model
		default:
			rule: null
			percentage: 0

	class Values extends Backbone.Collection
		model: Value
		initialize: (collection) ->
			selected = new Value(collection[0])
			@setSelected(selected)
		setSelected: (model) =>
			# Notifying of changed selection
			if (@selected?)
				@trigger("unselected", @selected)

			# Specifying new selection
			@selected = model
			@trigger("selected", @selected)
		getSelected: () =>
			@selected


	class GoalConfigurationChoice extends Backbone.Model
		defaults:
			bid : []
			totalTimeoutRule: []
			emailReminderRule: []
			phoneReminderRule: []
			privacyRule: []
			moveTimeoutRule: []
			supporterConfiguration: []
			observerConfiguration: []
			shareRule: []
		url:
			App.Utils.toUrl('/configuration/my/choice')
		initialize: () ->
			self = @
			@once "sync", () ->
				bidModel = _.map(self.get("bid"), (bid) ->
					{
						rule: bid,
						percentage: 0
					}
				)

				self.bid = new Values(bidModel)
				self.bid.on "selected", () -> self.toConfiguration()

				self.totalTimeoutRule = new Values(self.get("totalTimeoutRule"))
				self.totalTimeoutRule.on "selected", () -> self.toConfiguration()

				self.emailReminderRule = new Values(self.get("emailReminderRule"))
				self.emailReminderRule.on "selected", () -> self.toConfiguration()

				self.phoneReminderRule = new Values(self.get("phoneReminderRule"))
				self.phoneReminderRule.on "selected", () -> self.toConfiguration()

				self.privacyRule = new Values(self.get("privacyRule"))
				self.privacyRule.on "selected", () -> self.toConfiguration()

				self.moveTimeoutRule = new Values(self.get("moveTimeoutRule"))
				self.moveTimeoutRule.on "selected", () -> self.toConfiguration()

				self.supporterConfiguration = new Values(self.get("supporterConfiguration"))
				self.supporterConfiguration.on "selected", () -> self.toConfiguration()

				self.observerConfiguration = new Values(self.get("observerConfiguration"))
				self.observerConfiguration.on "selected", () -> self.toConfiguration()

				self.shareRule = new Values(self.get("shareRule"))
				self.shareRule.on "selected", () -> self.toConfiguration()

				self.toConfiguration()

		toConfiguration: () =>
			# Step 1. Calculate percentage
			percentage = 0
			percentage += @totalTimeoutRule.getSelected().get('percentage')
			percentage += @emailReminderRule.getSelected().get('percentage')
			percentage += @phoneReminderRule.getSelected().get('percentage')
			percentage += @privacyRule.getSelected().get('percentage')
			percentage += @moveTimeoutRule.getSelected().get('percentage')
			percentage += @supporterConfiguration.getSelected().get('percentage')
			percentage += @observerConfiguration.getSelected().get('percentage')
			percentage += @shareRule.getSelected().get('percentage')

			@set("percentage", percentage)

			# Step 2. Calculate bid
			bid = @bid.getSelected().get("rule")
			interest = _.clone(bid)
			interest.amount = (interest.amount * (100 + percentage)) / 100
			bid = {
				amount: bid
				interest: interest
			}

			# Step 3. Calculate selected configuration
			selected = {
				bid: bid
				totalTimeoutRule: @totalTimeoutRule.getSelected().attributes
				emailReminderRule: @emailReminderRule.getSelected().attributes
				phoneReminderRule: @phoneReminderRule.getSelected().attributes
				privacyRule:  @privacyRule.getSelected().attributes
				moveTimeoutRule: @moveTimeoutRule.getSelected().attributes
				supporterConfiguration: @supporterConfiguration.getSelected().attributes
				observerConfiguration: @observerConfiguration.getSelected().attributes
				shareRule: @shareRule.getSelected().attributes
			}

			# Step 4. Set selected configuration
			@setSelected(new GoalConfiguration(selected))

		setSelected: (model) =>
			# Notifying of changed selection
			if (@selected?)
				@trigger("unselected", @selected)

			# Specifying new selection
			@selected = model
			@trigger("selected", @selected)
		getSelected: () =>
			@selected


	class GoalConfigurations extends Backbone.Collection
		model: GoalConfiguration
		initialize: () ->
			self = @
			@once "sync", () ->
				@setSelected(self.find((el) -> true))
		url:
			App.Utils.toUrl('/configuration/my')
		setSelected: (model) =>
			# Notifying of changed selection
			if (@selected?)
				@trigger("unselected:#{@selected.get('configurationKey')}", @selected)
				@trigger("unselected", @selected)

			# Specifying new selection
			@selected = model
			@trigger("selected:#{@selected.get('configurationKey')}", @selected)
			@trigger("selected", @selected)
		getSelected: () =>
			@selected

	API =
		getConfigurations: () ->
			configurations = new GoalConfigurations()
			configurations.fetch()
			configurations
		getChoices: () ->
			choices = new GoalConfigurationChoice()
			choices.fetch()
			choices

	App.reqres.setHandler 'goal:configuration:entities:list', () -> API.getConfigurations()
	App.reqres.setHandler 'goal:configuration:entities:choice', () -> API.getChoices()
