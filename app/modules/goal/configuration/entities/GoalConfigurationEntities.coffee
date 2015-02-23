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


	MY_CONNECTIONS = App.request 'player:profile:entities:connections:my'

	class IntervalGoalConfigurationBuilder extends Backbone.Model
		defaults:
			base            : null
			basePrice       : 0
			maxPrice        : 0
			baseInterval    : 0
			basePercentage  : 0
			intervalRules   : []
		url:
			App.Utils.toUrl('/configuration/my/interval')
		initialize: () ->
			@on "change:bet", (model, value, options) ->
				bet = model.get('bet') - (model.get('baseInterval') + model.get('basePrice'))
				intervalRules = model.get('intervalRules')
				rate = model.get('basePercentage')
				if (model.get('base')?)
					configuration = _.clone(model.get('base'))
					for intervalRule in intervalRules
						if (bet > 0)
							bet -= intervalRule.interval
							rate += intervalRule.percentage
							if (intervalRule.rule.type == "rule:privacy")
								configuration.privacyRule = intervalRule.rule
							else if (intervalRule.rule.type == "rule:share")
								newShareRule = _.clone(intervalRule.rule)
								newShareRule.providers = _.uniq(_.union(configuration.shareRule.providers, intervalRule.rule.providers))
								configuration.shareRule = newShareRule
							else if (intervalRule.rule.type == "rule:timeout")
								configuration.moveTimeoutRule = intervalRule.rule
							else
								throw "unknown rule #{JSON.stringify(intervalRule)} #{intervalRule.rule.type}"
					configuration.bet.amount.amount = Math.round(model.get('bet'))
					configuration.bet.interest.amount = Math.round((model.get('bet') * (100 + rate)) / 100)
					model.set('configuration', configuration)

		linkTo: (construction) =>
			construction.listenTo @, "change:configuration", (interval) ->
				construction.set('configuration', interval.get('configuration'))
			construction.set("configuration", @get('configuration'))

		parse: (res) ->
			maxPrice = res.basePrice + res.baseInterval
			price = res.basePrice
			percentage = 100 + res.basePercentage
			res.intervalRules = _.filter(res.intervalRules, (intervalRule) ->
				if (intervalRule.rule.type == "rule:share")
					# Check all providers exist in connections
					allExist = !(_.find(intervalRule.rule.providers, (provider) -> !MY_CONNECTIONS.get(provider)?))
					allExist
				else
					true
			)
			_.forEach(res.intervalRules, (rule) ->
				price = rule.interval + price
				rule.value = price
				percentage = rule.percentage + percentage
				rule.totalPercentage = percentage
				maxPrice += rule.interval
			)
			res.bet = res.basePrice
			res.maxPrice = maxPrice
			res.configuration = res.base
			res


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
					self.configuration.set('bet', self.calculateBid())
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

		linkTo: (construction) =>
			construction.listenTo @configuration, "change", (model) ->
				construction.set('configuration', model.attributes)
			construction.set("configuration", @configuration.attributes)

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
		linkTo: (construction) =>
			construction.set("configuration", @getSelected())
			construction.listenTo @, "selected", (model) ->
				construction.set('configuration', model.attributes)
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
		getInterval: () ->
			interval = new IntervalGoalConfigurationBuilder()
			interval.fetch()
			interval

	App.reqres.setHandler 'goal:configuration:entities:list', () -> API.getConfigurations()
	App.reqres.setHandler 'goal:configuration:entities:choice', () -> API.getChoices()
	App.reqres.setHandler 'goal:configuration:entities:interval', () -> API.getInterval()
