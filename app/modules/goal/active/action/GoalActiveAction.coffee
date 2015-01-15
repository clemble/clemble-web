require './new/GoalActiveActionNew'
require './bid/GoalActiveActionBid'
require './surrender/GoalActionSurrender'
require './support/GoalActiveSupport'
require './entities/GoalActiveActionEntities'

@App.module "GoalActiveActionApp", (GoalActiveActionApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false
