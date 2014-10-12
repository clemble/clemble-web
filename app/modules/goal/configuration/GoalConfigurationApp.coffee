require './entities/GoalConfigurationEntities'
require './list/GoalConfigurationList'

@App.module "GoalConfigurationApp", (GoalConfigurationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false
