@App.module "GoalConfigurationApp.Interval", (Interval, App, Backbone, Marionette, $, _) ->

	Controller =
		showInterval: (interval, region) ->
			intervalConfigurationView = new GoalIntervalView
				model: interval
			region.show intervalConfigurationView

	class GoalIntervalView extends Marionette.ItemView
		template: require "./templates/configuration_interval"
		behaviors:
			StickIt: {}
		bindings:
			'#bet': {
				observe: 'bet',
			}
		modelEvents:
			'change'  : 'render'


	App.reqres.setHandler "goal:configuration:interval", (interval, region) -> Controller.showInterval(interval, region)