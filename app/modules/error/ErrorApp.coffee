require './show/ErrorShow'

@App.module "ErrorApp", (ErrorApp, App, Backbone, Marionette, $, _) ->
	@startWithParent = false

	API =
		error404: (path) ->
			App.request "error:show:404", path, App.mainRegion
		error500: (path) ->
			App.request "error:show:500", path, App.mainRegion

	class ErrorApp.Router extends Marionette.AppRouter
		appRoutes:
			'error/404': 'error404'
			'error/500': 'error500'


	App.addInitializer ->
		new ErrorApp.Router
			controller: API