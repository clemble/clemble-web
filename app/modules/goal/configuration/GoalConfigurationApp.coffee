require './entities/GoalConfigurationEntities'
require './list/GoalConfigurationList'

@App.module "GoalConfigurationApp", (GoalApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false
