require './new/GoalActiveActionNew'
require './bid/GoalActiveActionBid'
require './surrender/GoalActionSurrender'
require './support/GoalActiveSupport'
require './reached/GoalActionReached'
require './entities/GoalActiveActionEntities'
require './bet/GoalBetAction'

@App.module "GoalActiveActionApp", (GoalActiveActionApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false
