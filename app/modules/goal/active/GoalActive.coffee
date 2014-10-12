require './entities/GoalActiveEntities'
require './list/GoalActiveList'

@App.module "GoalActiveApp", (GoalActiveApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false
