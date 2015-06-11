require './SearchPlayerApp.module'
require './SearchPlayerApp.controller'
require './SearchPlayerApp.directive'

@App.module "SearchApp.Player", (Player, App, Backbone, Marionette, $, _) ->
	@startWithParent = false
