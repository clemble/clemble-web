@App.module "GoalConfigurationApp.Interval", (Interval, App, Backbone, Marionette, $, _) ->

	Controller =
		showInterval: (interval, region) ->
			intervalConfigurationView = new GoalIntervalFull
				model: interval
			region.show intervalConfigurationView
		showIntervalShort: (interval, region) ->
			intervalConfigurationView = new GoalIntervalShort
				model: interval
			region.show intervalConfigurationView

	class GoalIntervalFull extends Marionette.ItemView
		template: require "./templates/configuration_interval"
		behaviors:
			StickIt: {}
		bindings:
			'#bet': {
				observe: 'bet'
			}
		modelEvents:
			'change'  : 'render'

	RULE_ICON_TEMPLATE = require './templates/interval_rule_label'

	class GoalIntervalShort extends Marionette.ItemView
		template: require "./templates/configuration_interval_short"
		behaviors:
			StickIt: {}
		bindings:
			'#bet': {
				observe: 'bet',
				sliderOptions: (model) ->
					start = model.get("basePrice")
					range = { min: start, max: model.get("maxPrice") }
					options = {
						start: start,
						connect: "lower",
						range: range
					}
					options
				pips: (model) ->
					start = model.get("basePrice")
					pips = _.map(model.get('intervalRules'), (intervalRule) ->
						start = intervalRule.value
						label = RULE_ICON_TEMPLATE(intervalRule)
						pip = {
							value : start
							label : label
						}
						pip
					)
					pips
			}
		modelEvents:
			'change'  : 'render'


	App.reqres.setHandler "goal:configuration:interval", (interval, region) -> Controller.showInterval(interval, region)
	App.reqres.setHandler "goal:configuration:interval:short", (interval, region) -> Controller.showIntervalShort(interval, region)