require './entities/GoalActiveEntities'
require './list/GoalActiveList'
require './action/GoalActiveAction'

@App.module "GoalApp.GoalActiveApp", (GoalActiveApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false
