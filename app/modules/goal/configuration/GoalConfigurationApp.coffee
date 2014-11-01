require './entities/GoalConfigurationEntities'
require './list/GoalConfigurationList'

@App.module "GoalApp.GoalConfigurationApp", (GoalConfigurationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false
