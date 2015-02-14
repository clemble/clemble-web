require './new/GoalActiveActionNew'
require './bid/GoalActiveActionBid'
require './surrender/GoalActionSurrender'
require './support/GoalActiveSupport'
require './reached/GoalActionReached'
require './entities/GoalActiveActionEntities'

@App.module "GoalActiveActionApp", (GoalActiveActionApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false
