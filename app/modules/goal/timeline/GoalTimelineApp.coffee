require './entities/GoalTimelineEntities'
require './list/GoalTimeline'

@App.module "GoalTimelineApp", (GoalTimelineApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false