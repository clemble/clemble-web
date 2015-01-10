@App.module "GoalConfigurationApp.Choice", (Choice, App, Backbone, Marionette, $, _) ->

	class GoalConfigurationChoice extends Marionette.ItemView
		template: require './templates/choices'
		modelEvents:
			'sync'    : 'render'
			'change'  : 'render'

	Controller =
		listChoices: (choice, region) ->
			configurationsView = new GoalConfigurationChoice
				model: choice
			region.show configurationsView

	App.reqres.setHandler "goal:configuration:choice", (choice, region) -> Controller.listChoices(choice, region)
