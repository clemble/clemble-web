require './search.player.module'
require './search.player.controller'
require './search.player.directive'

@App.module "SearchApp.Player", (Player, App, Backbone, Marionette, $, _) ->
	@startWithParent = false
