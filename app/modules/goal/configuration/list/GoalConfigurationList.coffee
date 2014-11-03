@App.module "GoalConfigurationApp.List", (List, App, Backbone, Marionette, $, _) ->

	class GoalConfiguration extends Marionette.ItemView
		# Markup copied from http://www.cssflow.com/snippets/pricing-table :)
		template: require './templates/goal_configuration'
		tagName  : 'div'
		className: () => 'plan'
		initialize: () ->
			# In case this model was selected add active class
			@listenTo @model.collection, "selected:#{@model.get('configurationKey')}", () ->
				@$el.addClass("plan-tall")
			# In case this model was unselected remove active class
			@listenTo @model.collection, "unselected:#{@model.get('configurationKey')}", () ->
				@$el.removeClass("plan-tall")
		modelEvents:
			'sync' : 'render'
		events:
			'click': () -> @model.collection.setSelected(@model)


	class GoalConfigurations extends Marionette.CompositeView
		template: require './templates/goal_configurations'
		childView: GoalConfiguration
		childViewContainer: "div"

	Controller =
		listConfigurations: (configurations, region) ->
			configurationsView = new GoalConfigurations
				collection: configurations
			region.show configurationsView

	App.reqres.setHandler "goal:configuration:list", (configurations, region) -> Controller.listConfigurations(configurations, region)
