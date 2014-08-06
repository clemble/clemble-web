require './entities/GoalEntities'
require './show/GoalShow'


@App.module "GoalApp", (GoalApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false