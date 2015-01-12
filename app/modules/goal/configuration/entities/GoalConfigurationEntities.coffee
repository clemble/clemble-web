@App.module "GoalConfigurationApp.Entities", (Entities, App, Backbone, Marionette, $, _) ->


	class GoalConfiguration extends Backbone.Model
		defaults:
			privacyRule: null

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
			shareRule: []
		url:
			App.Utils.toUrl('/configuration/my/choice')
		initialize: () =>
			self = @

			@configuration = new GoalConfiguration()

			link = (name) ->
				self[name] = new Values()
				self[name].on "selected", (model) ->
					self.configuration.set(name, model.attributes.rule)
					self.configuration.set('bid', self.calculateBid())
				self.once 'sync', () ->
					self[name].add(self.get(name))
					self[name].trigger("sync")

			link('bid', @)
			link('totalTimeoutRule', @)
			link('emailReminderRule', @)
			link('phoneReminderRule', @)
			link('privacyRule', @)
			link('moveTimeoutRule', @)
			link('supporterConfiguration', @)
			link('shareRule', @)

		calculateBid: () =>
			if (@totalTimeoutRule.getSelected()? &&
					@emailReminderRule.getSelected()? &&
					@phoneReminderRule.getSelected()? &&
					@privacyRule.getSelected()? &&
					@moveTimeoutRule.getSelected()? &&
					@supporterConfiguration.getSelected()? &&
					@shareRule.getSelected()? &&
					@bid.getSelected()?
			)
				# Step 1. Calculate percentage
				percentage = 0
				percentage += @totalTimeoutRule.getSelected().get('percentage')
				percentage += @emailReminderRule.getSelected().get('percentage')
				percentage += @phoneReminderRule.getSelected().get('percentage')
				percentage += @privacyRule.getSelected().get('percentage')
				percentage += @moveTimeoutRule.getSelected().get('percentage')
				percentage += @supporterConfiguration.getSelected().get('percentage')
				percentage += @shareRule.getSelected().get('percentage')

				@set("percentage", percentage)

				# Step 2. Calculate bid
				bid = @bid.getSelected().attributes
				interest = _.clone(bid)
				interest.amount = (interest.amount * (100 + percentage)) / 100

				# Step 3. Calculate selected configuration
				{ amount: bid, interest: interest }
			else
				{ amount: 0, interest: 0 }



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
