require './entities/GoalTrackEntities'
require './show/GoalTrackPending'

@App.module "GoalTrackApp", (GoalTrackApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false