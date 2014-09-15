require './entities/GoalConstructionEntities'
require './new/GoalConstructionNew'

@App.module "GoalConstructionApp", (Entities, App, Backbone, Marionette, $, _) ->
	@startWithParent = false