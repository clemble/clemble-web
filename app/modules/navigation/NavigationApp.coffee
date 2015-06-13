require './navigation.module'
require './navigation.controller'

@App.module "NavigationApp", (NavigationApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	App.reqres.setHandler "navigation:list", () ->
		console.log("Navigation called")
		AngularStarter.start(App.navigationRegion, 'cl.navigation', require './navigation')