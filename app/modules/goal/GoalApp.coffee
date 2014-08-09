require './entities/GoalEntities'
require './pending/GoalPendingShow'
require './new/GoalNew'

@App.module "GoalApp", (GoalApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false