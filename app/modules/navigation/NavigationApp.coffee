require './NavigationApp.module'
require './NavigationApp.controller'

@App.module "NavigationApp", (NavigationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	App.reqres.setHandler "navigation:list", () ->
		AngularStarter.start(App.navigationRegion, 'navigation', require './navigation')