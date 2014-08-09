@App.module "ErrorApp.Show", (Show, App, Backbone, Marionette, $, _) ->

	Controller =
		show: (path, region) ->
			errorView = new Error
				model: new Backbone.Model(path: path)
			region.show errorView

	class Error extends Marionette.ItemView
		template: require './templates/404'

	App.reqres.setHandler "error:show", (path, region) -> Controller.show(path, region)