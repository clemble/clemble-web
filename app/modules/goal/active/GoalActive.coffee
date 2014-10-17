require './entities/GoalActiveEntities'
require './list/GoalActiveList'
require './action/GoalActiveAction'

@App.module "GoalActiveApp", (GoalActiveApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false
