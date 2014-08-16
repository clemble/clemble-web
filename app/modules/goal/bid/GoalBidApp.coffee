require './entities/GoalBidEntities'
require './show/GoalBidShow'

@App.module "GoalBidApp", (GoalBidApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false