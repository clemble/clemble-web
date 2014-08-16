require './entities/GoalStatusEntities'
require './new/GoalStatusNew'

@App.module "GoalStatusApp", (GoalStatusApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false