require './entities/GoalStatusEntities'
require './show/GoalStatusShow'
require './list/GoalStatusList'

@App.module "GoalStatusApp", (GoalStatusApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false