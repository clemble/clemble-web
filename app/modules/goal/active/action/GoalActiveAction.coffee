require './bid/GoalActiveActionBid'
require "./new/GoalActiveActionNew"
require "./entities/GoalActiveActionEntities"

@App.module "GoalActiveActionApp", (GoalActiveActionApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false
