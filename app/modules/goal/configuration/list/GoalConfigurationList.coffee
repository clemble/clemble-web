@App.module "GoalConfigurationApp.List", (List, App, Backbone, Marionette, $, _) ->

	class GoalConfiguration extends Marionette.ItemView
		template: require './templates/goal_configuration'
		modelEvents:
			'sync' : 'render'

	class GoalConfigurations extends Marionette.CompositeView
		template: require './templates/goal_configurations'
		childView: GoalConfiguration
		childViewContainer: "tbody"

	Controller =
		listConfigurations: (configurations, region) ->
			configurationsView = new GoalConfigurations
				collection: configurations
			region.show configurationsView

	App.reqres.setHandler "goal:configuration:list", (configurations, region) -> Controller.listConfigurations(configurations, region)
