require './entities/GoalStatusEntities'
require './show/GoalStatusShow'

@App.module "GoalStatusApp", (GoalStatusApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false