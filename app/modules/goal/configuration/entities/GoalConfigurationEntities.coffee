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
		initialize: () ->
			self = @
			@once "sync", () ->
				@setSelected(self.find(() -> true))
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
		initialize: () =>
			self = @

			link = (name) ->
				self[name] = new Values()
				self[name].on "selected", () -> self.toConfiguration()
				self.once 'sync', () ->
					options = _.map(self.get(name), (option) ->
						if (option.rule?)
							option
						else
							{
								rule: option
								percentage: 0
							}
					)
					self[name].add(options)
					self[name].trigger("sync")
					self.toConfiguration()

			link('bid', @)
			link('totalTimeoutRule', @)
			link('emailReminderRule', @)
			link('phoneReminderRule', @)
			link('privacyRule', @)
			link('moveTimeoutRule', @)
			link('supporterConfiguration', @)
			link('observerConfiguration', @)
			link('shareRule', @)

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
