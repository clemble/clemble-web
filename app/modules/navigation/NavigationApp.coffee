require './entities/NavigationEntities'
require './list/NavigationList'

@App.module "NavigationApp", (NavigationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false