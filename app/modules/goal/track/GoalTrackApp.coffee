require './entities/GoalTrackEntities'
require './show/GoalTrackShow'

@App.module "GoalTrackApp", (GoalTrackApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false