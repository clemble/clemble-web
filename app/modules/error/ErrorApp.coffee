require './show/ErrorShow'

@App.module "ErrorApp", (ErrorApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		error: (path) ->
			App.request "error:show", path, App.mainRegion

	class ErrorApp.Router extends Marionette.AppRouter
		appRoutes:
			#TODO this does not work as expected
			'*path': 'error'
			'error': 'error'


	App.addInitializer ->
		new ErrorApp.Router
			controller: API