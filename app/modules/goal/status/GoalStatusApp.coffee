require './entities/GoalStatusEntities'
require './new/GoalStatusNew'
require './list/GoalStatusList'

@App.module "GoalStatusApp", (GoalStatusApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false