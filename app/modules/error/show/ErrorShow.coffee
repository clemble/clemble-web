@App.module "ErrorApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		show404: (path, region) ->
			errorView = new Error404
				model: new Backbone.Model(path: path)
			region.show errorView
		show500: (path, region) ->
			errorView = new Error500
				model: new Backbone.Model(path: path)
			region.show errorView

	class Error404 extends Marionette.ItemView
		template: require './templates/404'

	class Error500 extends Marionette.ItemView
		template: require './templates/500'

	App.reqres.setHandler "error:show:404", (path, region) -> Controller.show404(path, region)
	App.reqres.setHandler "error:show:500", (path, region) -> Controller.show500(path, region)