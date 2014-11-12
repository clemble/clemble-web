require './entities/GoalTimelineEntities'

@App.module "GoalTimelineApp", (GoalTimelineApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false